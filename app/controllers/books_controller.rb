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

    @book=Book.new
    @user = current_user
  end

   def show
     #params[:id]はURLにあるidをparamsがうけとり、そのidのレコードをfindでとってくる
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
      @book = Book.find(params[:id])
      render :edit
    end
   end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  def create
    #book_paramsが呼び出され(下のbook_paramsメソッド)で厳選された値がindexやshowから送られてきたからそれを@bookという変数(bookという名前の箱)に代入
    @book = Book.new(book_params)
    #投稿フォームにはログイン中のユーザーidが入力されないから、bookのuser_idカラムにログイン中のユーザーidを代入
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


  #ここから下はこのcontrollerの中でしか呼び出せませんという境界線
    private
   # 送られてきたデータからモデル名を指定し保存を許可するカラムを指定
   #params・・・送られてきた値を受け取るメソッドのこと
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
