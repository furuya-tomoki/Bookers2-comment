class Favorite < ApplicationRecord
  belongs_to :user
	belongs_to :book
		# １：Nの関連付け =「1」の値
	validates_uniqueness_of :book_id, scope: :user_id
	# ユニーク制約
	# scopeがないと「1投稿」に対して「1いいね」しか付けることができない
	#= 「1投稿=book_id」に対して「１人につき=user_id」「1いいね」つけれる
end
