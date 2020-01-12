class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log in user and redirect to user's show page
      redirect_to user_path
    else
      flash.now[:danger] = "Invalid credentials"
      render 'new'
    end
  end

  def destroy
  end
end
