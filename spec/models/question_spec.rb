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

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question, :text) }
  subject { question }

  it { is_expected.to be_versioned }

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:title) }

    context 'as invalid kind' do
      let(:question) { build(:question, kind: 'foo') }

      it { is_expected.not_to be_valid }
      it { expect(subject.errors_on(:kind)).to include('foo is not a valid kind') }
    end

    context 'as enumerable kind' do
      Question::ENUMERABLE_KINDS.each do |kind|
        context "#{kind} with 2 answers" do
          let(:question) { build(:question, kind.to_sym, answers_count: 2) }

          it { is_expected.to be_valid }
        end
      end

      Question::ENUMERABLE_KINDS.each do |kind|
        context "#{kind} with less than 2 answers" do
          let(:question) { build(:question, kind.to_sym, answers_count: 1) }

          it { is_expected.not_to be_valid }
          it do
            expect(subject.errors_on(:answers)).to \
              include('multiple answers needed')
          end
        end
      end
    end

    context 'as diverse kind' do
      Question::DIVERSE_KINDS.each do |kind|
        context kind do
          let(:question) { build(:question, kind.to_sym) }

          it { is_expected.to be_valid }
        end
      end
    end
  end
end
