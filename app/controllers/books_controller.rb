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
      # update後にidが割り振られる！
        redirect_to book_path(@book.id)
        flash[:notice]="You have updated book successfully."
    else
    # バリデーションを起こしたとき(タイトルやボディを空欄)はupdate時に、@bookの中身は更新されるけど, データベースに保存はされない(バリデーションで引っかかってるから)
      # だから、ここで@book = Book.find(params[:id])の記述すると, 更新前のデータに上書きされるからうまくいかない
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
    #これがないとバリデーションのときのエラー文がviewにあるときはUser must exist エラー文がないときは、何も起きずにelseの処理
    @book.user_id = current_user.id
    if @book.save
      # create成功後にidが割り振られる！バリデーションの時は@bookの中身は変わるけどテーブルに保存されないから、idは振られない
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
