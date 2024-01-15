class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservation, only: [:show, :edit, :update]
  
    def index
      # ユーザーの予約一覧を表示
      @reservations = current_user.reservations
    end
  
    def new
      # 新規予約フォーム
      @reservation = current_user.reservations.build
    end
  
    def create
      # 予約の登録処理
      @reservation = current_user.reservations.build(reservation_params)
      if @reservation.save
        redirect_to reservations_path, notice: '予約が完了しました。'
      else
        render :new
      end
    end
  
    def show
      # 予約の詳細ページ
    end
  
    def edit
      # 予約の編集ページ
    end
  
    def update
      # 予約情報の更新
      if @reservation.update(reservation_params)
        redirect_to @reservation, notice: '予約情報が更新されました。'
      else
        render :edit
      end
    end
  
    private
  
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
  
    def reservation_params
      # 予約情報のストロングパラメータ
      params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_people, :room_id)
    end
  end
  