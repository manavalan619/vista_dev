unless ContentCategory.any?
  ['Travel', 'Women\'s Fashion', 'Men\'s Fashion', 'Inspiration',
   'Health and Fitness', 'Lifestyle', 'Watches', 'Sports'].each do |name|
    ContentCategory.create(name: name)
  end
end
