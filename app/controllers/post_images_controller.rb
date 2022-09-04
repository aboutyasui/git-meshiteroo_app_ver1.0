class PostImagesController < ApplicationController
  def new
    @post_image=PostImage.new #新規登録用のモデルを作成
  end

 # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save#対象のカラム（ここではimageとshop_name）にデータが保存されること
      redirect_to post_images_path
    else
      render :new
    end

    #以下コメントアウト(if無いしver)
    #@post_image = PostImage.new(post_image_params)#投稿するデータを PostImage モデルに紐づくデータとして保存する準備
    #@post_image.user_id = current_user.id
    # user_idは画像投稿を行う際に、「どのユーザーが投稿したのか」を「ユーザーの ID で判断する」ためのカラムである
    #current_user は、コードに記述するだけで、ログイン中のユーザーの情報を取得できる記述です。
    #current_user は,devise のヘルパーメソッドであるため、devise を導入しないと使用することができません。
    #@post_image.save
    #redirect_to post_images_path
  end

  def index
    @post_images = PostImage.page(params[:page])
    #pageメソッドは、ページネーションにおけるページ数を指定
    #ビューのリクエストの際paramsの中にpageというキーが追加されて、その値がビューで指定したページ番号となる。
  end

  def show
    @post_image = PostImage.find(params[:id]) #アクション内にparams[:id]と記述することで、詳細画面で呼び出される投稿データを URLの/posts/:id 内の:idで判別可能にする。
    #今回はレコードを1件だけ取得するので、インスタンス変数名は単数形の「@post_image」にします。
    @post_comment = PostComment.new
    #コメントを投稿するためのインスタンス変数を定義する
  end

  def edit
  end

  def destroy
    @post_image =  PostImage.find(params[:id]) #削除するPostImageレコードを取得
    @post_image.destroy #削除する処理
    redirect_to post_images_path #PostImageの一覧ページへ戻る
  end

   private
  # ストロングパラメータ(改竄データを送信した場合も、そのデータは保存される→脆弱性を防ぐ仕組みのこと)
  def post_image_params #post_image__params内では、保存したいデータの絞り込みが行われています。
    params.require(:post_image).permit(:shop_name, :caption, :image)
  end

end
