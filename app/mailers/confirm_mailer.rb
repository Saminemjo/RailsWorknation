class ConfirmMailer < ApplicationMailer
  def registration_confirmation
    @request = params[:request]
    @url = 'https://worknation.herokuapp.com'
    mail(to: @request.email,
         subject: 'WorkNation Waiting List subscription')
  end

  def registration_raise(user_email, r, index)
    @index = index
    @r = r
    @url = 'https://worknation.herokuapp.com'
    mail(to: user_email,
         subject: 'Always motived to join WorkNation ?')
  end
end
