class CoverPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :book_index do
    process :resize_to_fit => [250, 350]
  end

  version :book_show do
    process resize_to_fit: [325, 475]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
