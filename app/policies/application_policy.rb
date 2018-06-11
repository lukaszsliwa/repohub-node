class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def admin?
    user.admin?
  end

  def index?
    user.admin? || user.permissions.find_by_value(Permission.values[:"#{record.to_s.pluralize}_index"])
  end

  def show?
    user.admin? || user.permissions.find_by_value(Permission.values[:"#{record.to_s.pluralize}_show"])
  end

  def create?
    user.admin? || user.permissions.find_by_value(Permission.values[:"#{record.to_s.pluralize}_create"])
  end

  def new?
    create?
  end

  def update?
    user.admin? || user.permissions.find_by_value(Permission.values[:"#{record.to_s.pluralize}_update"])
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || user.permissions.find_by_value(Permission.values[:"#{record.to_s.pluralize}_destroy"])
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
