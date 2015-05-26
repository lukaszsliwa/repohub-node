class Repository < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :space

  validates :handle, uniqueness: {scope: :space_id}, presence: true

  def to_param
    handle
  end
end
