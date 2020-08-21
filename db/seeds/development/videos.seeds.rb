after 'development:content_categories' do
  unless Video.any?
    Video.create(
      name: 'Sample video',
      organisation: Organisation.first,
      url: 'https://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4',
      description: 'Placeholder seeded video for development purposes',
      vista_admin: VistaAdmin.first,
      published: true,
      published_at: Date.today,
      content_categories: [ContentCategory.all.sample]
    )
  end
end
