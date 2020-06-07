class DeviseMailerPreview < ActionMailer::Preview

  def reset_password_instructions
    # http://localhost:3000/rails/mailers/devise_mailer/reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, "faketoken")
  end

  def email_changed
    # http://localhost:3000/rails/mailers/devise_mailer/email_changed
    Devise::Mailer.email_changed(User.first)
  end

  def password_change
    # http://localhost:3000/rails/mailers/devise_mailer/password_change
    Devise::Mailer.password_change(User.first)
  end
end
