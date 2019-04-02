class SessionsController < ApplicationController

  def create
    #takes in two parameters, username and password

    @user = User.find_by(username: params[:user][:username])

    if @user && @user.password == params[:user][:password]
      # go and create the sessions
      #@user.sessions = Session.create() //this doesn't really work
      session = @user.sessions.create
      cookies.permanent.signed[:todolist_session_token] = {
        value: session.token,
        httponly: true
      }

      render json: {
        success: true
      }
    else
      #password is wrong or the user coudln't be found
      return render json: { success: false }, status: 404
    end
  end

  def authenticated
    token = cookies.signed[:todolist_session_token]
    session = Session.find_by(token: token)
    if session
      user = session.user
      return render json: {
        authenticated: true,
        username: user.username
      }
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
    token = cookies.signed[:todolist_session_token]
    session = Session.find_by(token: token)
    #destroy session if it can be found by token
    if session and session.destroy
      render json: {
              success: true
      }
    else
      render json: {
              success: false
              #test
      }
    end
  end

end
