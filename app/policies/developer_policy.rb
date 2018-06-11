class DeveloperPolicy < ApplicationPolicy
  def allow?
    user.admin? || ((record.is_a?(User) && record != user) || record == :developer) && user.permissions.find_by_value(Permission.values[:developers_allow]).present?
  end

  def deny?
    user.admin? || ((record.is_a?(User) && record != user) || record == :developer) && user.permissions.find_by_value(Permission.values[:developers_deny]).present?
  end
end