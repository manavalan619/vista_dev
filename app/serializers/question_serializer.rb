# == Schema Information
#
# Table name: questions
#
#  id                 :bigint(8)        not null, primary key
#  category_id        :integer
#  title              :citext
#  kind               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  locking_conditions :jsonb            not null
#  intro              :boolean          default(FALSE)
#  allows_note        :boolean          default(TRUE)
#  note_title         :string
#  processed_at       :datetime
#  text_style         :string           default("dark")
#  blur_background    :boolean          default(FALSE)
#  background_overlay :boolean          default(FALSE)
#
# Indexes
#
#  index_questions_on_allows_note   (allows_note)
#  index_questions_on_category_id   (category_id)
#  index_questions_on_intro         (intro)
#  index_questions_on_kind          (kind)
#  index_questions_on_processed_at  (processed_at)
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :category_id, :kind, :locking_conditions, :intro,
             :allows_note, :note_title, :text_style, :blur_background,
             :background_overlay

  has_one :photo
  has_many :answers
end
