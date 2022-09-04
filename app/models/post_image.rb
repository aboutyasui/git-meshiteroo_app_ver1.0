class PostImage < ApplicationRecord
   has_one_attached :image#画像を保存するメソッド
   belongs_to :user#1:N の「N」側にあたるモデルに、belongs_to を記載する必要がある
   has_many :post_comments, dependent: :destroy
   # 1:Nの関係において、「1」のデータが削除された場合、関連する「N」のデータも削除される設定
   has_many :favorites, dependent: :destroy
   # 1:Nの関係において、「1」（imageデータ）が削除された場合、関連する「N」（いいねデータ）も削除される

   #バリデーション
   validates :shop_name,presence: true
   validates :image,presence: true
   #validatesでは対象となる項目を指定し、入力されたデータのpresence(存在)をチェックする
   #trueと書くとデータが存在しなければならないという設定になる


  def get_image#これはアクションとは少し違い、特定の処理を名前で呼び出すことができるようになる
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)#favorited_by?メソッドを作成
    favorites.exists?(user_id: user.id)#引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
  end

end
