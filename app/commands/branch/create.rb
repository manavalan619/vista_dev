class Branch::Create
  prepend SimpleCommand

  def initialize(branch)
    @branch = branch
  end

  def call
    create_account
  end

  private

  def create_account
    return true if @branch.save
    @branch.errors.map { |key, value| errors.add(key, value) }
  end
end
