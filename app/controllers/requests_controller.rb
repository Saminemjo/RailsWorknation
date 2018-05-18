class RequestsController < ApplicationController
  # def index
  #   @requests = Request.all
  # end
  #
  # def show
  #   @request = Request.find(params[:id])
  # end

  # def edit
  #   @request = Request.find(params[:id])
  # end
  #
  # def update
  #   @request = Request.find(params[:id])
  #   if @request.update(Request_params)
  #     redirect_to Requests_path, success: 'Update success'
  #   else
  #     render 'edit'
  #   end
  # end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.valid?
      if @request.save
        @request.send :set_confirmation_token
        @request.raised_at = @request.created_at
        @request.save(validate: false)
        # Tell the ConfirmMailer to send a welcome email after save
        ConfirmMailer.with(request: @request).registration_confirmation.deliver_now
        redirect_to root_path, success: 'A confirmation email has been sent, please check your mailbox to complete your subscription on the waiting list.'
      end
    else
       render 'new'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to root_path, success: 'Request deleted'
  end

  def confirm_email
    request = Request.find_by_confirm_token(params[:token])
     if request
       request.send :validate_email
       request.save
       redirect_to root_path, success: 'Your email has been confirmed, you are registered to the waiting List. See you soon !'
     else
       redirect_to root_path, danger: "User doesn't exist"
     end
  end

  def confirm_raise
    request = Request.find_by_confirm_token(params[:token])
     if request
       request.send :validate_raise
       request.save
       redirect_to root_path, success: 'Your request has been confirmed, you are still registered to the waiting List. See you soon !'
     else
       redirect_to root_path, danger: "User doesn't exist"
     end
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone, :biography, :confirm_token)
  end
end
