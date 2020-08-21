class ConvertCategoryAndAnswerTitlesToCitext < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'citext'

    change_column :answers, :title, :citext
    change_column :categories, :title, :citext
    change_column :questions, :title, :citext
  end

  def down
    change_column :answers, :title, :string
    change_column :categories, :title, :string
    change_column :questions, :title, :string

    disable_extension 'citext'
  end
end
