class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:edit, :update, :destroy]
  before_action :set_room, only: [:confirm]

  def index
    @reservations = current_user.reservations
  end

  def new
    @reservation = Reservation.new
  end
  
  def create
    # @reservation = @room.reservations.new(reservation_params)
    # @reservation.user = current_user
    puts "####MAKING RESERVATION!!!!" 
    puts reservation_params
    @room = Room.find(params[:reservation][:room_id])

    @reservation = current_user.reservations.new(reservation_params)
    @reservation.total_price = calculate_total_price(@reservation)

    if @reservation.save
      redirect_to reservations_path
    else
      redirect_to room_path(@reservation.room), alert: '予約に失敗しました。'
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
  
  #予約編集ページを表示
  def edit
    @reservation = current_user.reservations.find(params[:id])
    @room = @reservation.room
  end
  
  #予約編集確認
  def edit_confirm
    @reservation = current_user.reservations.find(params[:reservation][:id])
    @reservation.assign_attributes(reservation_params) # 編集内容を仮に割り当てる
  
    if @reservation.valid? # 検証を行う
      @room = Room.find(@reservation.room_id)
      @total_price = calculate_total_price(@reservation)
      render :edit_confirm
    else
      @room = @reservation.room
      render :edit # エラーがあれば編集画面に戻る
    end
  end

 #予約編集確定
  def update
    @reservation = current_user.reservations.find(params[:id])
    @room = @reservation.room 

    if @reservation.update(reservation_params)
      @reservation.total_price = calculate_total_price(@reservation)
      @reservation.save
      redirect_to reservations_path
    else
      render :edit
    end
  end

  def confirm
    @reservation = Reservation.new(confirm_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user = current_user  # 現在のユーザーを予約に関連付ける

  
    if @reservation.valid?
      @total_price = calculate_total_price(@reservation)
      render :show
    else
      render 'rooms/show'
    end
  end
  
  
  
  

  def destroy
    puts "DELETING NOW"
    @reservation.destroy
    redirect_to reservations_path
    #@reservation = Reservation.find(params[:id])
    #if @reservation.destroy
      #puts "DELETED !!!"
    #end
  end

  private
  
  def calculate_total_price(reservation)
    # 支払い金額の計算
    (reservation.check_out_date - reservation.check_in_date).to_i * reservation.number_of_people * @room.price
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def set_room
    room_id = params[:reservation][:room_id]
    @room = Room.find(room_id)
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in_date, :check_out_date, :number_of_people)
  end
  
  def confirm_params
    params.require(:reservation).permit(:room_id, :check_in_date, :check_out_date, :number_of_people)
  end


end
