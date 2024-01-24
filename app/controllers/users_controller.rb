class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show_account_info, :edit_account_info, :update, :edit_profile, :update_profile]

  def show_account_info
    # ユーザーのアカウント情報を表示
  end

  def edit_account_info
    # ユーザー情報の編集ページ
  end

  def update
    # ユーザー情報の更新
    if @user.update(user_params)
      redirect_to show_account_info_user_path(@user)
    else
      render :edit_account_info
    end
  end

  def edit_profile
    # プロフィール編集ページ
  end

  def update_profile
    # プロフィール情報の更新
    if @user.update(profile_params)
      redirect_to show_profile_user_path(@user)
    else
      render :edit_profile
    end
  end

  def show_profile
    # プロフィール表示ページ
    @user = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:name, :icon_image, :introduction) 
  end
end
