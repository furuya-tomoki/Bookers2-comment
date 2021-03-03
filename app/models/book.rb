class Book < ApplicationRecord
  belongs_to :user
  	# １：Nの関連付け =「1」の値
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	# １：Nの関連付け =「N」の値
	# 「1」のデータが削除された場合、関連する「N」のデータも削除される設定
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
# 対象の値を空で入力できない制限を実行
# length: { maximum: 200 } = 文字の長さを最長２００文字の制限
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
		# 投稿がお気に入りしてあるかどうかを判定したいので
		# インスタンスメソッドなのでビューに送れる[if @book.favorited_by?(current_user)」
	end
end
