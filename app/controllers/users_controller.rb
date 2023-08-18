class UsersController < ApplicationController
  include PrivateMethodsConcern

  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all.order(:id)
    respond_to do |format|
      format.json { render json: @users }
      format.csv { send_data User.to_csv, filename: "users.csv" }
    end
  end

  def show
    return render_user_not_found unless @user
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User created successfully", user: @user }, status: :created
    else
      render_user_errors
    end
  end

  def update
    return render_user_not_found unless @user
    if @user.update(user_params)
      render json: { message: "User updated successfully", user: @user }
    else
      render_user_errors
    end
  end

  def destroy
    return render_user_not_found unless @user
    @user.destroy
    render json: { message: "User deleted successfully" }
  end
end
