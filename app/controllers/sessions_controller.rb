# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    member = Member.authenticate(omniauth)
    cookies[:access_token] = member.access_token if member
    redirect_to session.delete(:return_to) || root_url
  end

  def setup
    session[:return_to] = request.referer if params[:redirect_back]
    render :text => "Setup complete.", :status => 404
  end

  def destroy
    cookies[:access_token] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url
  end

end
