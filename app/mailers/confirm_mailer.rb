class ConfirmMailer < ApplicationMailer
  def registration_confirmation
    @request = params[:request]
    @url = 'https://worknation.herokuapp.com'
    mail(to: @request.email,
         subject: 'WorkNation Waiting List subscription')
  end

  def registration_raise(r, index)
    @index = index
    @r = r
    @url = 'https://worknation.herokuapp.com'
    mail(to: r.email,
         subject: 'Always motived to join WorkNation ?')
  end
end
