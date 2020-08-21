class Personality::Wine
  TITLE = 'Do you have a pallet for good wine?'.freeze

  def initialize(user)
    @user = user
  end

  def result
    case answer.try(:values)
    when 'No' then 1
    when 'Yes' then 4
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
