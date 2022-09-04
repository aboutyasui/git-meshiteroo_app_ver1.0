class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  #UserモデルとPostCommentモデルを関連付ける
end
