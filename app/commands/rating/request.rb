class Rating::Request
  prepend SimpleCommand

  def initialize(branch:, user:)
    @request = Notification::RatingRequest.new(object: branch, user: user)
  end

  def call
    return @request if @request.save
    @request.errors.map { |k, v| errors.add(k, v) }
    @request
  end
end
