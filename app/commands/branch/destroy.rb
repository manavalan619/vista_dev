class Branch::Destroy
  prepend SimpleCommand

  def initialize(branch)
    @branch = branch
  end

  def call
    destroy
  end

  private

  def destroy
    return true if @branch.destroy
    errors.add(:removing_branch, 'cannot remove branch')
  end
end
