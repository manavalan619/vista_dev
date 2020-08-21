class Branch::Update
  prepend SimpleCommand

  def initialize(branch, params)
    @branch = branch
    @params = params
  end

  def call
    update
  end

  private

  def update
    return true if @branch.update(@params)
    @branch.errors.map { |key, value| errors.add(key, value) }
  end
end
