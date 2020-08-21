class Rating::Rate
  prepend SimpleCommand

  def initialize(branch:, user:, value:)
    @rating = Rating.new(branch: branch, user: user, value: value)
  end

  def call
    return @rating if @rating.save
    @rating.errors.map { |k, v| errors.add(k, v) }
    @rating
  end
end
