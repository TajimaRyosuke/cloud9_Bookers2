class UsersController < ApplicationController
   before_action :correct_user, only: [:edit]
  def index
    @users = User.all
    @user = User.find(current_user[:id])
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'User date was successfully created'
    else
    render :edit
    end
  end


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
    redirect_to book_path, notice: 'Book was successfully created'
    else
    render templete: "books/index"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user.id==current_user.id
    redirect_to user_path(current_user)
    end
  end

  def following
    @user = User.find(params[:id]) #フォローされてる一人を抽出してる
    @users = @user.following_user
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
