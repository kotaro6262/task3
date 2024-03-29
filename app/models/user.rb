class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  # 上のメソッドのprocessedなどの意味を調べよう(ブックマークに追加済み(active_storageのvarient・・・ってやつ)）
# gemでimage_processingを導入することで, 画像サイズの変更が可能(カリキュラムのアプリ完成の２の1章)
 validates :name, length: {in: 2..20}, uniqueness: true
  validates :introduction, length: {maximum: 50}

end

