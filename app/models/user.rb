class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # 1:Nの関係において、「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image
  #has_one_attached :profile_imageという記述により、profile_imageという名前でActiveStorageで
  #プロフィール画像を保存できるように設定しました。

def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed#画像を縦横共に100pxのサイズに変換する
end

end
