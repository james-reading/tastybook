class CollectionPolicy < ApplicationPolicy
  def edit?
    record.user == user
  end
end
