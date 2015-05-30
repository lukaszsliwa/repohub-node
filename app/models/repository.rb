class Repository < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :space

  has_many :repository_users, dependent: :destroy
  has_many :users, through: :repository_users

  after_create  :exec_client_repository_create
  after_destroy :exec_client_repository_delete

  validates :handle, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }, uniqueness: {scope: :space_id}, presence: true

  scope :in_space, ->(space_id) { where(space_id: space_id) }

  def to_param
    handle
  end

  def path
    "#{handle_with_space}.git"
  end

  def handle_with_space
    space.present? ? [space.handle, handle].join('/') : handle
  end

  def exec_client_repository_create
    Exec::Client::Repository.new(db_id: id).save
  end

  def exec_client_repository_delete
    Exec::Client::Repository.delete id
  end

  def as_json(options = {})
    options[:methods] = [:path, :handle_with_space]
    super options
  end
end
