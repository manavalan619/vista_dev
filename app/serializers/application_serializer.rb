class ApplicationSerializer < ActiveModel::Serializer
  attribute :errors, if: :errors_present?

  def errors_present?
    object.try(:errors).try(:present?)
  end
end
