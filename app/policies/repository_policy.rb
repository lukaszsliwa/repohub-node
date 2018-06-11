class RepositoryPolicy < ApplicationPolicy
  class Scope
    attr_accessor :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin? || user.permissions.find_by_value(Permission.values[:repositories_index])
        scope.order('id DESC').all
      else
        user.repositories.order('id DESC').all
      end
    end
  end

  def show?
    user.admin? || user.repositories.exists?(record.id)
  end

  def allowed?
    show?
  end
end