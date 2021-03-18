class FavoritesController < ApplicationController
    before_action :authenticate_user!
# ログインしていない場合にログインページにリダイレクトさせる
  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
     # find_by = 主キー(id)以外のカラムを指定しても、見つかった1レコードを返せる」
    favorite.destroy
    redirect_to request.referer
  end
end
