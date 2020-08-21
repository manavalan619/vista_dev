class Interactions::Create
  prepend SimpleCommand

  def initialize(interaction_attributes)
    @interaction = Interaction.new(interaction_attributes)
  end

  def call
    return @interaction if @interaction.save
    @interaction.errors.map { |key, value| errors.add(key, value) }
    nil
  end
end
