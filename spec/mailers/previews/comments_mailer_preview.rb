class CommentsMailerPreview < ActionMailer::Preview

  def new
    # http://localhost:3000/rails/mailers/comments_mailer/new
    comment = Comment.last

    CommentsMailer.new_comment(comment)
  end
end
