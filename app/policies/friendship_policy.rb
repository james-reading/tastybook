class FriendshipPolicy < ApplicationPolicy

  def destroy?
    record.user == user
  end

  def accept?
    if record.friend
      record.friend == user
    else
      record.invitation_email == user.email
    end
  end
end
