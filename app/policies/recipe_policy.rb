class RecipePolicy < ApplicationPolicy

  def show?
    return true if record.user == user
    return true if user.friends.where(id: record.user).exists?
    return true if user.email == 'jamesreading473@gmail.com'
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
