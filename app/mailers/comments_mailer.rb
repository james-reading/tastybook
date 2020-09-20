class CommentsMailer < ApplicationMailer

  def new_comment(comment)
    @comment = comment

    mail to: comment.recipe.user.email
  end
end
