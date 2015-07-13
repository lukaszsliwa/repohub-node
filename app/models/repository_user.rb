class RepositoryUser < ActiveRecord::Base
  belongs_to :repository, counter_cache: :users_count
  belongs_to :user, counter_cache: :repositories_count

  after_create :exec_repository_user_create, :create_notification
  after_destroy :exec_repository_user_destroy

  validates :repository_id, uniqueness: {scope: :user_id}

  def exec_repository_user_create
    Exec::Client::User.find(user.login).post(:link, space: repository.space.try(:handle), handle: repository.handle, id: repository.token)
  end

  def exec_repository_user_destroy
    Exec::Client::User.find(user.login).delete(:link, space: repository.space.try(:handle), handle: repository.handle, id: repository.token)
  end

  def create_notification
    Notification.create(image: 'user', user: user, subject: "#{user.login} was successfully added to the #{repository.handle_with_space} members.")
  end
end
