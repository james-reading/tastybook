class FriendshipPolicy < ApplicationPolicy

  def destroy?
    record.user == user
  end
end
