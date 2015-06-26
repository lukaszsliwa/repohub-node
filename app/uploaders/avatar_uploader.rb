# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "avatar.png"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_fit => [96, 96]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
