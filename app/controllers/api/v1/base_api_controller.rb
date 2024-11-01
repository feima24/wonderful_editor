class Api::V1::BaseApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  # current_api_v1_userをcurrent_userとして使えるようにエイリアスを設定
  alias_method :current_user, :current_api_v1_user

  # ユーザーが認証されているかどうかを確認するメソッドも同様にエイリアスを設定
  alias_method :user_signed_in?, :api_v1_user_signed_in?

  # authenticate_user!も同様にエイリアス設定
  alias_method :authenticate_user!, :authenticate_api_v1_user!
end
