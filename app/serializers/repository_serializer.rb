class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :handle, :space_handle, :handle_with_space, :path, :allowed, :users_count

  def allowed
    scope.repositories.exists?(id)
  end

  def space_handle
    object.space.try(:handle)
  end
end
