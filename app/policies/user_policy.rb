class UserPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def update?
    @user.admin? || @user == @record
  end

  def show?
    @user.admin? || @user == @record
  end

  def destroy?
    @user.admin? || @user == @record
  end
end
