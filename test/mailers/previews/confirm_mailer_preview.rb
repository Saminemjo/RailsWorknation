# Preview all emails at http://localhost:3000/rails/mailers/confirm_mailer
class ConfirmMailerPreview < ActionMailer::Preview

  def registration_confirmation
    ConfirmMailer.registration_confirmation
  end
  def registration_raise
    ConfirmMailer.registration_raise
  end
end
