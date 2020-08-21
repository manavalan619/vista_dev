class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    @name ||= "#{super.chomp(File.extname(super))}-#{timestamp}.jpg" if original_filename.present? && super.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

  version :large do
    convert :jpg
    process :optimise
    process resize_to_limit: [1200, 1200]
  end

  version :thumb, from_version: :large do
    process resize_to_fill: [160, 160]
  end

  version :preview, from_version: :large do
    process :blur
    process resize_to_fill: [42, 42]
  end

  def optimise
    manipulate! do |img|
      # i.sampling_factor '4:2:0'
      img.gaussian_blur 0.05 # seemed to get better results than previous line
      img.strip
      img.quality 85
      img.depth 8
      img.interlace 'Plane'
      img.colorspace 'RGB'
    end
  end

  # reduce image noise and reduce detail levels
  #
  #   process :blur => [0, 8]
  #
  def blur(radius = 0, sigma = 32)
    manipulate! do |img|
      img.blur "#{radius}x#{sigma}"
      img = yield(img) if block_given?
      img
    end
  end

  # Strips out all embedded information from the image
  #
  #   process :strip
  #
  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end
end
