class AddCustomisationsToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :text_style, :string, default: 'light'
    add_column :questions, :blur_background, :boolean, default: false
    add_column :questions, :background_overlay, :boolean, default: false
  end
end
