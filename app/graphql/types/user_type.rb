Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, types.ID
  field :memberId, types.ID, property: :member_id
  field :firstName, types.String, property: :first_name
  field :lastName, types.String, property: :last_name
  field :name, types.String
  field :sharedAt do
    type Types::DateTimeType
    resolve lambda { |obj, _args, ctx|
      current_branch = ctx[:current_branch]
      share = Share.authorised.find_by(user: obj, branch: current_branch)
      share.try(:created_at)
    }
  end
  field :mood, types.String
  field :checkIn do
    type Types::CheckInType
    resolve lambda { |obj, _args, ctx|
      current_branch = ctx[:current_branch]
      obj.check_ins.future.for_branch(current_branch).first
    }
  end
  field :photo, Types::PhotoType
  field :jobTitle, types.String, property: :job_title
  field :company, types.String
  field :address, types.String
  field :gender, types.String
  field :personality do
    type Types::JsonType
    resolve lambda { |obj, _args, _ctx|
      Personality.new(obj).result
    }
  end
  field :requestCount do
    type types.Int
    resolve lambda { |obj, _args, ctx|
      current_branch = Branch.find(ctx[:current_branch_id])
      pending = current_branch.member_requests.pending.for_member(obj).count
      open = current_branch.member_requests.open.for_member(obj).count
      pending + open
    }
  end
end
