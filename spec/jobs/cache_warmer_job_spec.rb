require 'rails_helper'

RSpec.describe CacheWarmerJob, type: :job do
  let(:object) { build(:category) }

  it 'calls `cache_warm_attributes` on object' do
    expect(object).to receive_message_chain(:cache_warm_attributes, :each)
    CacheWarmerJob.perform_now(object)
  end
end
