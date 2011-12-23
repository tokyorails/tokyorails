# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  helper_method :current_user

  private

  def current_user
    @current_user ||= Member.authenticated.find_by_access_token!(cookies[:access_token])
    rescue ActiveRecord::RecordNotFound
      cookies[:access_token] = nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
end
