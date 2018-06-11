class KeyPolicy < ApplicationPolicy
  def show?
    user.admin? || record.is_a?(Key) && user == record.user || user.permissions.find_by_value(Permission.values[:keys_index])
  end

  def destroy?
    user.admin? || record.is_a?(Key) && user == record.user || user.permissions.find_by_value(Permission.values[:keys_destroy])
  end
end