class Notification < ActiveRecord::Base
  belongs_to :user

  def image_with_extension
    "#{image}.png"
  end
end
