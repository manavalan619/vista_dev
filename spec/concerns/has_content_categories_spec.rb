require 'spec_helper'

shared_examples_for 'has_content_categories' do
  let(:model) { described_class }
  let(:model_symbol) { model.to_s.underscore.to_sym }
  let(:hidden_content_category) { FactoryBot.create(:content_category) }
  let(:visible_content_category) { FactoryBot.create(:content_category) }
  let!(:hidden_object) { create(model_symbol, content_categories: [ hidden_content_category ]) }
  let!(:visible_object) { create(model_symbol, content_categories: [ visible_content_category]) }
  let!(:crossover_object) { create(model_symbol, content_categories: [ visible_content_category, hidden_content_category ]) }
  let(:user) { FactoryBot.build(:user, preferences: { hidden_categories: [hidden_content_category.id] }) }

  describe '#for_user' do
    subject { model.for_user(user) }

    it 'should return objects for the given user' do
      expect(subject).to include(visible_object)
    end

    it 'should not return objects in categories the user has hidden' do
      expect(subject).to_not include(hidden_object)
    end

    it 'should not return objects in two categories, one of which the user has hidden' do
      expect(subject).to_not include(crossover_object)
    end
  end
end
