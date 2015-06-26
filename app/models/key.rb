require 'securerandom'

class Key < ActiveRecord::Base
  belongs_to :user, counter_cache: :keys_count

  before_validation :generate_token, on: :create, if: -> { self.token.blank? }

  after_commit  :generate_authorized_keys

  validates :content, presence: true
  validates :token, uniqueness: true, format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\Z/ }

  def filename
    "#{token}.pub"
  end

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
