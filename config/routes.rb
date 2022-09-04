Rails.application.routes.draw do
 devise_for :users #devise を使用する際に URL として users を含むことを示しています
 # resources :books 質問対応にて作成(コメントアウト)
 #get 'homes/about'=>'homes#about' ,as:'about'（コメントアウト）
 root 'homes#top'
 resources :post_images, only: [:new, :create, :index, :show, :destroy] do
 #コメントは、投稿画像に対してコメントされる。つまりpost_commentsは、post_imagesは親子関係になる
  resource :favorites, only: [:create, :destroy]#resourceは「それ自身のidが分からなくても、関連する他のモデルのidから特定できる」といった場合に用いる
  #resourceとなっている点...いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため

  resources :post_comments,only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 end

resources :users,only: [:show, :edit, :update]
end