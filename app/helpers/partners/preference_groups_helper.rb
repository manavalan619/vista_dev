module Partners::PreferenceGroupsHelper
  def preference_groups_json(preference_groups)
    preference_groups.map do |pg|
      {
        id: pg.id,
        title: pg.title,
        questions: pg.questions.pluck(:title)
      }
    end
  end
end
