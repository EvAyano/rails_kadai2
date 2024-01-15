class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      # 全ての部屋を表示
      @rooms = Room.all
    end
  
    def show
      # 部屋の詳細を表示
      @rooms = current_user.rooms
    end
  
    def new
      # 新規部屋登録フォーム
      @room = Room.new
    end
  
    def create
      @room = current_user.rooms.new(room_params)
      if @room.save
        redirect_to @room, notice: '部屋が正常に登録されました。'
      else
        render :new
      end
    end
  
    def edit
      # 部屋の編集フォーム
      
    end
  
    def update
      # 部屋の更新処理
      if @room.update(room_params)
        redirect_to @room, notice: '部屋情報が更新されました。'
      else
        render :edit
      end
    end
  
    def destroy
      # 部屋の削除処理
      @room.destroy
      redirect_to rooms_url, notice: '部屋が削除されました。'
    end
  
    private
  
    def set_room
      #@room = Room.find(params[:id])
    end
  
    def room_params
      params.require(:room).permit(:name, :description, :price, :address, :image)
    end
end
