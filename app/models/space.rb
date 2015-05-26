class Space < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'

  has_many :repositories, dependent: :destroy

  validates :handle, uniqueness: true, presence: true

  def to_param
    handle
  end
end
