require 'rails_helper'

RSpec.describe 'admin/questions/edit', type: :view do
  before(:each) do
    @question = assign(:question, create(:question, :text))
  end

  it 'renders the edit question form' do
    render

    assert_select 'form[action=?][method=?]', url_for([:admin, @question]), 'post' do
      assert_select 'select[name=?]', 'question[category_id]'
      assert_select 'input[name=?]', 'question[title]'
      assert_select 'select[name=?]', 'question[kind]'
      assert_select 'input[name=?]', 'question[intro]'
      assert_select 'input[name=?]', 'question[allows_note]'
      assert_select 'input[name=?]', 'question[note_title]'
    end
  end
end
