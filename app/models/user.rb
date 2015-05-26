class User < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'

  has_many :keys, dependent: :destroy

  validates :login, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  def to_param
    login
  end
end
