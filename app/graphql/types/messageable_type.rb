class Types::MessageableType < GraphQL::Schema::Union
  description 'Users or StaffMembers who may send a MemberRequest message'
  possible_types Types::UserType, Types::StaffMemberType

    def self.resolve_type(object, context)
      if object.is_a?(StaffMember)
        Types::StaffMemberType
      else
        Types::UserType
      end
    end
end
