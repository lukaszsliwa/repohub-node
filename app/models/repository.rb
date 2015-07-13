require 'securerandom'

class Repository < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :space, counter_cache: :repositories_count

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users

  before_validation :generate_token, on: :create

  before_create  :exec_client_repository_create
  before_destroy :exec_client_repository_delete

  after_create :create_notification, :create_repository_user

  validates :handle, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }, uniqueness: {scope: :space_id}, presence: true

  scope :in_space, ->(space_id) { where(space_id: space_id) }

  def generate_token
    begin
      self.token = SecureRandom.hex[0..8]
    end while Repository.where(token: self.token).exists?
  end

  def path
    "#{handle_with_space}.git"
  end

  def handle_with_space
    space.present? ? [space.handle, handle].join('/') : handle
  end

  def space_handle
    space.respond_to?(:handle) ? space.handle : nil
  end

  def exec_client_repository_create
    Exec::Client::Repository.create(db_id: token)
  end

  def exec_client_repository_delete
    Exec::Client::Repository.delete token
  end

  def create_notification
    Notification.create(image: 'repository', subject: "The repository #{handle_with_space} was successfully created.")
  end

  def create_repository_user
    RepositoryUser.create(repository_id: id, user_id: created_by_id)
  end

  def as_json(options = {})
    options[:methods] = [:path, :handle_with_space, :space_handle]
    options[:except] = [:token, :space_id]
    super options
  end
end
