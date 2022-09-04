class CreatePostimages < ActiveRecord::Migration[6.1]
  def change
    create_table :postimages do |t|#カラムの定義をする

      t.integer :user_id#投稿したユーザーを識別するID（users テーブルの id を保存する）
      t.string  :shop_name#お店の名前
      t.text :caption#画像の説明

      t.timestamps
    end
  end
end
