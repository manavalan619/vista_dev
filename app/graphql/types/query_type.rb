Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :branches do
    token_context 'manager'
    type types[Types::BranchType]
    resolve ->(obj, args, ctx) {
      current_user = ctx[:current_user]
      case current_user
      when Admin
        current_user.organisation.branches
      when BranchManager
        current_user.assigned_branches
      else
        Branch.none
      end
    }
  end

  field :currentBranch do
    token_context 'staff'
    type Types::BranchType
    resolve ->(_obj, _args, ctx) { ctx[:current_branch] }
  end

  field :roles do
    token_context 'manager'
    branch_required true
    type types[Types::RoleType]
    resolve ->(obj, args, ctx) {
      current_branch = ctx[:current_branch]
      current_branch.roles
    }
  end

  field :staffMembers do
    token_context 'manager'
    branch_required true
    role_required true
    type types[Types::StaffMemberType]
    resolve lambda { |_obj, _args, ctx|
      current_branch = ctx[:current_branch]
      current_role = ctx[:current_role]
      current_branch.staff_members_for_role(current_role)
    }
  end

  field :user do
    token_context 'staff'
    branch_required true
    type Types::UserType
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      current_branch = ctx[:current_branch]
      # current_branch.users.find_by_member_id(args[:id])
      current_branch.users.find(args[:id])
    }
  end

  field :users do
    argument :search, types.String
    argument :before, types.ID
    argument :limit, types.Int

    token_context 'staff'
    branch_required true
    type types[Types::UserType]

    resolve ->(obj, args, ctx) {
      current_branch = ctx[:current_branch]
      users = current_branch.users.arriving_soonest_at_branch(current_branch)
      limit = args[:limit] || 25

      users = users.search(args[:search]) if args[:search]
      users = users.before(args[:before]) if args[:before]
      users.limit(limit)
    }
  end

  field :nearbyUsers do
    argument :memberIds, types[types.ID]

    token_context 'staff'
    branch_required true
    type types[Types::UserType]

    resolve ->(obj, args, ctx) {
      current_branch = ctx[:current_branch]
      if args[:memberIds]
        ShareRequestJob.perform_later(current_branch, args[:memberIds])
        current_branch.users.in_member_ids(args[:memberIds])
      else
        User.none
      end
    }
  end

  field :categories do
    argument :root, types.Boolean
    argument :parentId, types.ID
    type types[Types::CategoryType]

    resolve lambda { |obj, args, ctx|
      if args[:root] && args[:root] == true
        Category.roots
      elsif args[:parentId]
        Category.children_of(args[:parentId])
      else
        Category.all
      end
    }
  end

  field :category do
    token_context 'staff'
    argument :id, !types.ID
    type Types::CategoryType
    resolve ->(_obj, args, _ctx) { Category.find(args[:id]) }
  end

  field :preferenceGroups do
    token_context 'staff'
    role_required true

    argument :userId, types.ID

    type types[Types::PreferenceGroupType]

    resolve lambda { |_obj, _args, ctx|
      current_role = ctx[:current_role]
      # current_role.preference_groups
      current_role
        .preference_groups
        .distinct
        .joins(:role_preference_group_assignments)
        .select(%(
          preference_groups.*,
          role_preference_group_assignments.position AS position,
          role_preference_group_assignments.column AS column
        ).squish)
    }
  end

  field :topQuestions do
    token_context 'staff'
    role_required true

    type types[Types::QuestionType]

    resolve lambda { |obj, args, ctx|
      current_role = ctx[:current_role]
      current_role.top_questions
    }
  end

  field :question do
    # token_context 'staff'

    type Types::QuestionType

    argument :id, !types.ID

    resolve lambda { |obj, args, ctx|
      Question.find_by(id: args[:id])
    }
  end

  field :questions do
    token_context 'staff'
    role_required true

    type types[Types::QuestionType]

    argument :search, types.String
    argument :userId, types.ID
    argument :limit, types.Int, default_value: 25
    argument :page, types.Int, default_value: 1

    resolve lambda { |obj, args, ctx|
      questions = Question.page(args[:page]).per(args[:limit])
      questions = questions.search(args[:search]) if args[:search]
      questions
    }
  end

  field :interactions do
    token_context 'staff'
    role_required true

    type types[Types::InteractionType]

    argument :userId, !types.ID
    argument :limit, types.Int, default_value: 25
    argument :page, types.Int, default_value: 1

    resolve lambda { |obj, args, ctx|
      Interaction.where(
        branch_id: ctx[:current_branch_id],
        user_id: args[:userId]
      ).page(args[:page]).per(args[:limit])
    }
  end

  field :partnerInteractions do
    token_context 'staff'
    role_required true

    type types[Types::PartnerInteractionType]

    resolve lambda { |obj, args, ctx|
      current_role = ctx[:current_role]
      interactions = current_role.interactions.delete_if(&:blank?)
      interactions.map { |i| { value: i, label: i.humanize } }
    }
  end

  field :memberRequests do
    token_context 'staff'
    branch_required true
    role_required true

    argument :userId, types.ID
    argument :limit, types.Int, default_value: 25
    argument :page, types.Int, default_value: 1
    argument :search, types.String
    argument :status, types.String

    type types[Types::MemberRequestType]
    resolve lambda { |obj, args, ctx|
      current_role = ctx[:current_role]
      current_branch = ctx[:current_branch]
      request_types = current_role.member_request_types

      requests = current_branch.member_requests.in_types(request_types)

      if args[:userId]
        requests = requests.for_member(args[:userId])
      end

      requests = requests.search(args[:search]) if args[:search] && !args[:search].blank?
      requests = requests.in_status(args[:status]) if args[:status] && !args[:status].blank?

      requests
        .order('last_message_sent_at DESC')
        .page(args[:page])
        .per(args[:limit])
    }
  end

  field :memberRequestTypes do
    token_context 'staff'
    branch_required true

    type types[Types::MemberRequestTypeType]
    resolve lambda { |obj, args, ctx|
      current_branch = ctx[:current_branch]
      current_branch.business_unit.member_request_types
    }
  end

  field :memberRequestMessages do
    token_context 'staff'

    argument :memberRequestId, types.ID
    argument :limit, types.Int, default_value: 25
    argument :page, types.Int, default_value: 1

    type types[Types::MemberRequestMessageType]
    resolve lambda { |obj, args, ctx|
      current_user = ctx[:current_user]
      current_user.member_requests
        .find(args[:memberRequestId])
        .member_request_messages
        .order('created_at DESC')
    }
  end
end
