class ApplicationController < ActionController::Base
   before_action :authenticate_user!,except: [:top]#ログインしていない状態でトップページ以外のアクセスされた場合は、ログイン画面へリダイレクトする
   #before_actionメソッドは、このコントローラが動作する前に実行されます
   #authenticate_userメソッドは、 :authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
   #exceptは指定したアクションをbefore_actionの対象から外します。 Meshiterroではトップページのみログイン状態に関わらず、アクセス可能とするためにtopアクションを指定しています。


   #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行されます。
   before_action :configure_permitted_parameters, if: :devise_controller?



   def after_sign_in_path_for(resource)#after_sign_in_path_forは,サインイン後にどこに遷移するかを設定しているメソッド
    post_images_path
   end
#About ページをサインイン後の遷移先に設定します。
   def after_sign_out_path_for(resource)
    about_path
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
  end


end
