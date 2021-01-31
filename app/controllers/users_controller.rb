class UsersController < ApplicationController

  def upload_photo
    @user = User.find_by(id:params[:id])
    @user.photo.attach(photo_params[:photo])

    binding.pry
    if @user.photo.attached?
      render json: { user: UserSerializer.new(@user)}
    else
      render json: {errors: "No picture attached"}
    end
    
    private
    
    def photo_params
      params.permit(:photo)
    end
  end