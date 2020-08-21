require 'rails_helper'

RSpec.describe 'admin/questions/new', type: :view do
  before(:each) do
    @question = assign(:question, build(:question, :text))
  end

  it 'renders the new question form' do
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
