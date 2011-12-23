# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    member = Member.authenticate(omniauth)
    cookies[:access_token] = member.access_token if member
    redirect_to root_url
  end

  def destroy
    cookies[:access_token] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url
  end

end
