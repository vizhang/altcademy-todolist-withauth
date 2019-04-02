class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    puts "creating user: " + @user.inspect
    if @user && @user.save
      return render json: { user: { username: @user.username } }
    else
      return render json: { status: false }, status: 400
    end
  end

  private

  def user_params
    p = params.require(:user).permit(:username, :password,)
    puts "user_params are: " + p.inspect
    return p
  end
end
