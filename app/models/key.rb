require 'securerandom'

class Key < ActiveRecord::Base
  belongs_to :user

  before_validation :generate_token, on: :create

  after_commit  :generate_authorized_keys

  validates :content, presence: true
  validates :token, uniqueness: true, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }

  def to_param
    token
  end

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while Key.where(token: self.token).count >= 1
  end

  def generate_authorized_keys
    keys = user.keys.map { |key| {value: key.content} }
    Exec::Client::Key.create(user_id: user.login, keys: keys)
  end
end
