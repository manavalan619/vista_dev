class CheckIn::Create
  prepend SimpleCommand

  def initialize(user, branch, params)
    @user = user
    @branch = branch
    @params = params
  end

  def call
    save_check_in
  end

  private

  def check_in
    @check_in ||= begin
      @user.check_ins.find_or_initialize_by(branch: @branch, arrival_date: arrival_date)
    end
  end

  def save_check_in
    return check_in if check_in.update @params
    check_in.errors.map { |key, value| errors.add(key, value) }
    check_in
  end

  def arrival_date
    @params[:arrival_date]
  end
end
