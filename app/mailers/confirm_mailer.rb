class ConfirmMailer < ApplicationMailer
  def registration_confirmation
    @request = params[:request]
    @url = 'https://worknation.herokuapp.com'
    mail(to: @request.email,
         subject: 'WorkNation Waiting List subscription')
  end

  def registration_raise(request, index)
    @index = index
    @request = request
    @url = 'https://worknation.herokuapp.com'
    mail(to: request.email,
         subject: 'Always motived to join WorkNation ?')
  end
end
