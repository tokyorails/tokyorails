# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= Member.authenticated.find_by_access_token!(cookies[:access_token])
  rescue ActiveRecord::RecordNotFound
    cookies[:access_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      respond_to do |format|
        format.html do
          session[:return_to] = request.path
          redirect_to '/auth/meetup?redirect_back=yes'
        end
        format.json do
          head :unauthorized
        end
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
end
