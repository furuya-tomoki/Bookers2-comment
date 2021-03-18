class UsersController < ApplicationController
  before_action :authenticate_user!
  # ログインしていない場合にログインページにリダイレクトさせる
  before_action :ensure_correct_user, only: [:edit, :update]
# 投稿者だけが編集・保存できる
  def show
    @user = User.find(params[:id])
    # id=1のデータをfindメソッドを利用してデータベースから取得し、@userに格納
    @books = @user.books
    @book = Book.new
    # 空のインスタンスをView = 「form_with」に渡す
  end

  def index
    @users = User.all
    @book = Book.new
    # 空のインスタンスをView = 「form_with」に渡す
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    # 投稿者だけが編集できる
    @user = User.find(params[:id])
    unless @user == current_user
       # unless文 → もしも、評価が偽(false)であれば○○する
      redirect_to user_path(current_user)
      # 投稿者以外のユーザーだったら、リダイレクトへ
    end
  end
end
