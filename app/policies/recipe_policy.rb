class RecipePolicy < ApplicationPolicy

  def show?
    record.user_id = user.id
  end

  class Scope < Scope
    def resolve
      user.recipes
    end
  end
end
