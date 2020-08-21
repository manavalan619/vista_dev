module HasContentCategories
  extend ActiveSupport::Concern

  included do
    scope :in_category, -> (categories) { includes(:content_categories).where(content_categories: { id: categories }) }
  end

  module ClassMethods
    def for_user(user)
      excluded_ids = in_category(user.hidden_categories).pluck(:id)
      where.not(id: excluded_ids)
    end
  end
end
