#TODO/FIXME: remove?
class Partner::Create
  prepend SimpleCommand

  def initialize(partner, params)
    @partner = partner
    user_attributes = %i[email password]
    user_params = {}
    user_attributes.each do |attribute|
      user_params[attribute] = params[attribute]
      params.delete(attribute)
    end
    params[:user_attributes] = user_params
    @partner.assign_attributes params
  end

  def call
    create_account
  end

  private

  def create_account
    return true if @partner.save
    @partner.errors.map { |key, value| errors.add(key, value) }
  end

  def random_token
    format('%016d', SecureRandom.random_number(10**16))
  end
end
