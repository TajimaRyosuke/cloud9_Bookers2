class BooksController < ApplicationController
   before_action :correct_user, only: [:edit]

  def index
    @books = Book.all
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
    redirect_to book_path(@book), notice: 'Book was successfully created'
    else
      @books = Book.all
      render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
    redirect_to book_path(@book), notice: 'Book was successfully updated'
    else
    render :edit
    end
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def correct_user
    @book = Book.find(params[:id])
    unless @book.user.id==current_user.id
    redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end