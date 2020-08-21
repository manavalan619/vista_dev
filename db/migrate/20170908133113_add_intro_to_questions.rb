class AddIntroToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :intro, :boolean
    add_index :questions, :intro
  end
end
