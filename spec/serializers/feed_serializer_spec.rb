require 'rails_helper'

RSpec.describe FeedSerializer do
  let(:feed) do
    Feed.new(
      articles: create_list(:article, 3),
      interactions: [
        create_list(:interaction, 3, :mood),
        create_list(:interaction, 3, :recommendation)
      ].flatten
    )
  end
  let(:serializer) { FeedSerializer.new(feed) }
  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['articles']).to be_a(Array) }
  it { expect(subject['interactions']).to be_a(Array) }
end
