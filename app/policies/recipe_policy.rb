class RecipePolicy < ApplicationPolicy

  def show?
    (record.user == user) ||
      user.friends.where(id: record.user).exists?
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      user.recipes
    end
  end
end
