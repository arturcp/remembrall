class SessionsController < ApplicationController
  def create
    # TODO: fetch the team_id and find the collection_id based on it.
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.slack_id if user
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
