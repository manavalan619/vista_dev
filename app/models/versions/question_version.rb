# == Schema Information
#
# Table name: question_versions
#
#  id             :bigint(8)        not null, primary key
#  item_type      :string           not null
#  item_id        :bigint(8)        not null
#  event          :string           not null
#  whodunnit      :string
#  object         :jsonb
#  object_changes :jsonb
#  ip_address     :inet
#  user_agent     :string
#  created_at     :datetime
#
# Indexes
#
#  index_question_versions_on_item_type_and_item_id  (item_type,item_id)
#

class Versions::QuestionVersion < Versions::Base
  versions_table :question_versions
  paper_trail_actor :vista_admin
end
