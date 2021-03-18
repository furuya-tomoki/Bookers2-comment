class BooksController < ApplicationController
   before_action :authenticate_user!
   #  ログインしていない場合にログインページにリダイレクトさせる
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  # # 投稿者だけが編集・保存・削除できる

  def show
    @book = Book.find(params[:id])
    # id=1のデータをfindメソッドを利用してデータベースから取得し、@bookへ格納
    @book_comment = BookComment.new
    # 空のインスタンスをView = 「form_with」に渡す
  end

  def index
    @books = Book.all
    # Bookモデル内のすべての投稿記事データを取得
    @book = Book.new
    # 空のインスタンスをView = 「form_with」に渡す

  end

  def create
    @book = Book.new(book_params)
    # １. データを新規登録するためのインスタンス作成
    @book.user_id = current_user.id
    if @book.save
    # ２. データをデータベースに保存するためのsaveメソッド実行
    # if = 正常に保存できた場合実行
      redirect_to book_path(@book), notice: "You have created book successfully."
      # 実行後のリダイレクト先を指定
      # notice = メッセージ表示
    else
      # else = 実行できなかった場合の処理
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      # if 無事にsaveできれば、リダイレクト実行
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
  # ここから下はcontrollerの中でしか呼び出せません」という意味

  def book_params
    # book_paramsではフォームで入力されたデータを受け取る
    params.require(:book).permit(:title, :body)
    # paramsはRailsで送られてきた値を受け取るためのメソッド
    # requireでデータのオブジェクト名(ここでは:list)を指定し、permitでキー（:title,:body）を指定し許可
  end

  def ensure_correct_user
    # 投稿者だけが編集できる
    @book = Book.find(params[:id])
    unless @book.user == current_user
   # unless文 → もしも、評価が偽(false)であれば○○する
      redirect_to books_path
    end
  end
end
