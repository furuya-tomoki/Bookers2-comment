class BookCommentsController < ApplicationController
    	before_action :authenticate_user!
    	#  ログインしていない場合にログインページにリダイレクトさせる

	def create
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		# current_userとして取得しているbook_commentには全て、ログインユーザーのidが格納される。
		if @book_comment.save
  		redirect_to book_path(@book.id)
		else
		  render 'books/show'
		end
	end

	def destroy
		@book = Book.find(params[:book_id])
  	book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
		redirect_to
		# 該当ページに遷移する直前に閲覧されていた参照元（遷移元・リンク元）ページのURL
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
