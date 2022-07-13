class BooksController < ApplicationController
  
   
  before_action :ensure_current_user,{only:[:edit,:update]}
 
  def ensure_current_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
  
  def index
    @books=Book.all
   
    @book = Book.new
    @user = current_user
  end

   def show
    @book = Book.find(params[:id])
       @user = @book.user
    @book_new = Book.new
     @book_comment = BookComment.new
     
   
   end

  def edit
    @book = Book.find(params[:id])
  end
   def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        redirect_to book_path(@book.id)
        flash[:notice]="You have updated book successfully."
    else
      render :edit
    end
   end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      # ログイン中のユーザーをインスタンスに渡す
      @user = current_user
      render :index
    end
  end
  
 
  
    private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
