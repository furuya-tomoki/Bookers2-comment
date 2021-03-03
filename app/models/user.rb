class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	# １：Nの関連付け =「N」の値
	# 「1」のデータが削除された場合、関連する「N」のデータも削除される設定
  attachment :profile_image, destroy: false
# 画像アップ用のメソッド（attachment）を追加してフィールド名に（profile_image）を指定

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # uniqueness = 同一データは1つのみ許可する
  # nameの値は文字数「2~20」で同一の名前は禁止
  validates :introduction, length: { maximum: 50 }
  # introductionの値は、文字数制限を最長50文字
end
