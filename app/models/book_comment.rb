class BookComment < ApplicationRecord
  belongs_to :user
	belongs_to :book
  # １：Nの関連付け =「N」の値

	validates :comment, presence: true
	# commentの値は空の入力不可能
end
