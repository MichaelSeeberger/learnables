class UserController < ApplicationController
  before_action :authenticate_user!

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    unless @user.valid_password?(params[:users][:password])
      flash.now[:alert] = 'Did not update password'
      @user.errors.add(:current_password, 'Wrong password')
      render 'edit_password'
      return
    end

    if @user.update(update_password_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      flash[:notice] = 'Password updated'
      redirect_to root_path
    else
      render "edit_password"
    end
  end

  def edit_email
    @user = current_user
  end

  def update_email
    @user = current_user
    unless @user.valid_password?(params[:users][:password])
      flash.now[:alert] = 'Wrong password'
      @user.errors.add(:password, 'Wrong Password')
      render "edit_email"
      return
    end

    if @user.update(update_email_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      flash[:notice] = 'Password updated'
      redirect_to root_path
    else
      render "edit_email"
    end
  end

  private

  def update_password_params
    params.require(:users).permit(:password, :password_confirmation)
  end

  def update_email_params
    params.require(:users).permit(:email)
  end
end
