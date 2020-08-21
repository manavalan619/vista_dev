class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    # NOTE: This was previously just
    # "imports/#{model.id}" but wasn't working in local dev
    # May need to revert this change if breaks on Heroku
    Rails.root.join("imports/#{model.id}")
  end
end
