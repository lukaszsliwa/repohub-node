class Space < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'

  has_many :repositories, dependent: :destroy

  after_create :create_notification

  validates :handle, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }, uniqueness: true, presence: true

  def to_param
    handle
  end

  def create_notification
    Notification.create(image: 'space', subject: "New work space #{handle} was successfully created.")
  end
end
