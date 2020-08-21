class Personality
  def initialize(user)
    @lifestyle = Personality::Lifestyle.new(user)
    @food = Personality::Food.new(user)
    @wine = Personality::Wine.new(user)
  end

  def result
    {
      lifestyle: @lifestyle.result,
      food: @food.result,
      wine: @wine.result
    }
  end
end
