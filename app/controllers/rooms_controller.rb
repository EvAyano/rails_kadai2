class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @rooms = Room.all
  
      if params[:area].present?
        @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%")
      end
  
      if params[:keyword].present?
        @rooms = @rooms.where('name LIKE :keyword OR description LIKE :keyword', keyword: "%#{params[:keyword]}%")
      end
    end


    def show
      print "部屋詳細"
    end
    
    def my_rooms
      @rooms = current_user.rooms
    end
  
    def new
      # 新規部屋登録フォーム
      @room = Room.new
    end
  
    def create
      @room = current_user.rooms.new(room_params)
      if @room.save
        redirect_to @room
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
        redirect_to @room
      else
        render :edit
      end
    end
  
    def destroy
      # 部屋の削除処理
      @room = Room.find(params[:id])
      @room.destroy
      redirect_to rooms_url
    end
  
    private

    def set_room
      @room = Room.find(params[:id])
    end
  
    def room_params
      params.require(:room).permit(:name, :description, :price, :address, :image)
    end
end
