after 'categories' do
  ########################## Hotel #############################
  hotel = Category.find_by(title: 'Hotel')

  Question.create_with(
    category: hotel,
    intro: true,
    kind: 'unordered_list',
    answers_attributes: [
      { title: 'Rest and relaxation' },
      { title: 'Visiting friends and family' },
      { title: 'Business reasons' },
      { title: 'Attending a conference, congress, seminar etc' },
      { title: 'Health' },
      { title: 'Sports and recreation' },
      { title: 'Other' }
    ]
  ).find_or_create_by(title: 'What are your main reasons to visit a hotel?')

  Question.create_with(
    category: hotel,
    intro: true,
    kind: 'option',
    answers_attributes: [
      { title: 'Yes' },
      { title: 'No' }
    ]
  ).find_or_create_by(title: 'Will your trip to the hotel be organized through a travel agency or another organizer?')

  Question.create_with(
    category: hotel,
    intro: true,
    kind: 'unordered_list',
    answers_attributes: [
      { title: 'No one' },
      { title: 'Partner' },
      { title: 'Family / relatives' },
      { title: 'Friends' },
      { title: 'Co-workers' },
      { title: 'Business partners' },
      { title: 'Other' }
    ]
  ).find_or_create_by(title: 'Who will accompany you on your visit to the hotel?')

  Question.create_with(
    category: hotel,
    intro: true,
    kind: 'option',
    answers_attributes: [
      { title: 'Every few years' },
      { title: 'Once a year' },
      { title: 'Several times (3-5) a year' },
      { title: 'More than 5 times a year' }
    ]
  ).find_or_create_by(title: 'How often do you stay at hotels?')

  Question.create_with(
    category: hotel,
    intro: true,
    kind: 'option',
    answers_attributes: [
      { title: 'Online' },
      { title: 'Via email' },
      { title: 'Via telephone' },
      { title: 'In person' },
      { title: 'Third party website' }
    ]
  ).find_or_create_by(title: 'What booking method do you prefer to use?')

  puts "Finished seeding Hotel questions"
end
