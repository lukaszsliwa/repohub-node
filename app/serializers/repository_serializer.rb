class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :handle, :handle_with_space, :path, :allowed

  def allowed
    scope.repositories.exists?(id)
  end
end
