class Personality::Food
  TITLE = 'How many times per month do you eat out?'.freeze

  def initialize(user)
    @user = user
  end

  def result
    case answer.try(:values)
    when '0-5' then 1
    when '6-10' then 2
    when '11-15' then 3
    when '16+' then 4
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
