class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:top, :about]
 #全てのアクションの前に、ユーザーがログインしているかどうか確認する！ログインしていない場合はユーザをログインページにリダイレクトする！ただし、topアクションと、aboutアクションが呼び出された場合は、除くよ。という意味-->


    before_action :configure_permitted_parameters, if: :devise_controller?



# 引数のresourceには、認証の対象となるモデル（今回はUser）のオブジェクト(ログインしたuserのレコード)が渡される。
def after_sign_in_path_for(resource)
    user_path(current_user.id)
end

# def after_sign_up_path_for(resource)
#     after_sign_in_path_for(resource) if is_navigational_format?
#   end
# みたいな記述がdeviseのコントローラーにあるからsign_up_path_forにあるからいらない
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end