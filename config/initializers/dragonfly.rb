require 'dragonfly'

app = Dragonfly[:images]

app.configure_with(:imagemagick)
app.configure_with(:rails)
app.configure_with(:heroku, 'org.tokyorails.dragonfly') if Rails.env.production?

app.define_macro(ActiveRecord::Base, :image_accessor)

app.configure do |c|
  c.job :thumb do |size|
    process :convert, '-auto-orient'
    process :thumb, size
    encode  :jpg, '-strip -quality 80'
  end
  c.url_format = '/media/:job.:format'
end
