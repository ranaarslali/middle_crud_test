module PrivateMethodsConcern
  extend ActiveSupport::Concern

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :address, :phone, :email, :identity_card)
  end

  def render_user_errors
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end

  def render_user_not_found
    render json: { error: "User not found" }, status: :not_found
  end
end
