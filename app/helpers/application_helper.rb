# -*- encoding : utf-8 -*-
module ApplicationHelper
  def icon(*attributes)
    html_class = attributes.map { |attr| "icon-#{attr}" }.join(' ')
    "<i class='#{html_class}'></i> ".html_safe
  end
end
