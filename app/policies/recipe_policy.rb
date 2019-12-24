class RecipePolicy < ApplicationPolicy

  def show?
    record.user_id = user.id
  end

  def edit?
    show?
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
