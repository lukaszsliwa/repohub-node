class RepositoryUser < ActiveRecord::Base
  belongs_to :repository
  belongs_to :user

  after_create :exec_repository_user_create
  after_destroy :exec_repository_user_destroy

  validates :repository_id, uniqueness: {scope: :user_id}

  def exec_repository_user_create
    Exec::Client::User.find(user.login).post(:link, space: repository.space.try(:handle), handle: repository.handle, id: repository.token)
  end

  def exec_repository_user_destroy
    Exec::Client::User.find(user.login).delete(:link, space: repository.space.try(:handle), handle: repository.handle, id: repository.token)
  end
end
