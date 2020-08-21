# NB: this has been renamed as the real answer model was added later on
class CreateUserAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.json :content

      t.timestamps
    end

    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end
