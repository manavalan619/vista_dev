lorem = 'Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. Nulla vitae elit libero, a pharetra augue. Aenean lacinia bibendum nulla sed consectetur. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras mattis consectetur purus sit amet fermentum.'.freeze
url = 'https://picsum.photos/2000/2000/?random'.freeze

attributes = {
  description: lorem,
  photo_attributes: { remote_image_url: url }
}

hotel = Category.create_with(attributes).find_or_create_by(title: 'Hotel')

facilities = hotel.children.create_with(attributes).find_or_create_by(title: 'Facilities')
parking = hotel.children.create_with(attributes).find_or_create_by(title: 'Parking')
budget = hotel.children.create_with(attributes).find_or_create_by(title: 'Budget')
room = hotel.children.create_with(attributes).find_or_create_by(title: 'Room')

%w[Facilities Parking Budget Room].each do |title|
  hotel.children.create_with(attributes).find_or_create_by(title: title)
end
