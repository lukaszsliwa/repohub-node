require "securerandom"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :created_by, class_name: 'User'

  has_many :keys, dependent: :destroy

  has_many :repository_users, dependent: :destroy
  has_many :repositories, through: :repository_users

  has_many :spaces, through: :repositories

  has_many :permissions, dependent: :destroy

  before_validation :generate_token, :generate_password, on: :create

  after_create  :exec_client_user_create
  after_destroy :exec_client_user_destroy

  validates :login, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }, uniqueness: true, presence: true
  validates :token, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  def as_json(options = {})
    options[:except] = [:avatar]
    super options
  end

  def generate_password
    self.password = self.password_confirmation = Devise.friendly_token.first 8
  end

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while User.where(token: self.token).count >= 1
  end

  def to_param
    login
  end

  def exec_client_user_create
    Exec::Client::User.new(login: login).save
  end

  def exec_client_user_destroy
    Exec::Client::User.delete login
  end
end
