class Types::PartnerInteractionType < Types::BaseObject
  graphql_name 'PartnerInteraction'

  field :label, String, null: false
  field :value, String, null: false
end
