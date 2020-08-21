class Personality::Lifestyle
  TITLE = 'How would you rate your lifestyle?'.freeze

  def initialize(user)
    @user = user
  end

  def result
    case answer.try(:values)
    when 'As economical as possible' then 1
    when 'Spend money on special occasions' then 2
    when 'Like the finer things in life' then 3
    when 'Spare no expense' then 4
    else 0
    end
  end

  private

  def question
    @question ||= Question.find_by(title: TITLE)
  end

  def answer
    @answer ||= @user.answers.find_by(question: question)
  end
end
