class SettingsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params_user)
        format.html { redirect_to edit_settings_path, notice: 'Account was successfully updated.' }
      else
        format.html { render action: :edit }
      end
    end
  end

  def params_user
    params[:user].permit(:first_name, :last_name, :email, :avatar, :remove_avatar)
  end
end