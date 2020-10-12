class FriendshipPolicy < ApplicationPolicy

  def destroy?
    record.user == user
  end

  def accept?
    record.friend == user
  end
end
