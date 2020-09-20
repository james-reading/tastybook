class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :body, presence: true

  after_create :notify_recipe_user

  private

  def notify_recipe_user
    return if user == recipe.user

    CommentsMailer.new_comment(self).deliver_later(wait: 5.minutes)
  end
end
