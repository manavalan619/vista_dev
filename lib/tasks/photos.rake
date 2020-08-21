namespace :photos do
  desc 'Recreate all photo versions'
  task recreate_versions: :environment do
    if Rails.env.development? || Rails.env.test?
      Photo.find_each(&:recreate_versions!)
    else
      Photo.find_each do |photo|
        photo.safe_recreate_versions!
      rescue => e
        puts "ERROR: Photo: #{photo.id} -> #{e}"
      end
    end
  end
end
