class DogsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to dog_path(@dog), notice: '投稿に成功しました！'
    else
      render :new
    end
  end

  def edit
    @dog = Dog.find(params[:id])
    if @dog.user != current_user
      redirect_to dogs_path, alert: '不正なアクセスです'
    end
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dog_path(@dog), notice: '更新に成功しました！'
    else
      render :edit
    end
  end

  def destroy
    dog = Dog.find(params[:id])
    dog.destroy
    redirect_to dogs_path
  end

  private
    def dog_params
      params.require(:dog).permit(:title, :body, :image)
    end

end
