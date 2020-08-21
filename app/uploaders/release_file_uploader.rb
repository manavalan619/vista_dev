class ReleaseFileUploader < CarrierWave::Uploader::Base
  def store_dir
    "releases/#{model.id}"
  end
end
