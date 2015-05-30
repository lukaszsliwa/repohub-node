require "securerandom"

class User < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'

  has_many :keys, dependent: :destroy

  has_many :repository_users, dependent: :destroy
  has_many :repositories, through: :repository_users

  has_many :spaces, through: :repositories

  before_validation :generate_token

  after_create  :exec_client_user_create
  after_destroy :exec_client_user_destroy

  validates :login, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :token, uniqueness: true

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
