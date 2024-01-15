class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    before_action :set_user, only: [:show, :edit, :update, :edit_profile, :update_profile]
  
    def show
      # ユーザーの詳細ページ
    end
  
    def edit
      # ユーザー情報の編集ページ
    end
  
    def update
      # ユーザー情報の更新
      if @user.update(user_params)
        redirect_to @user, notice: 'アカウント情報が更新されました。'
      else
        render :edit
      end
    end
  
    def edit_profile
      # プロフィール編集ページ
    end
  
    def update_profile
      # プロフィール情報の更新
      if @user.update(profile_params)
        redirect_to @user, notice: 'プロフィールが更新されました。'
      else
        render :edit_profile
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      # ユーザー情報のストロングパラメータ（アカウント情報の編集用）
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
    def profile_params
      # プロフィール情報のストロングパラメータ（プロフィール編集用）
      params.require(:user).permit(:name, :icon_image)
    end
  end
  