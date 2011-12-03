module Meetup
  
  def self.import_members

    uri = URI('https://api.meetup.com/2/profiles.json')
    uri.query = URI.encode_www_form( { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561'})
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    response = http.start {|http| http.request(request) }

    # Due to this issue: http://redmine.ruby-lang.org/issues/2567 net/http does
    # not detect the meetup response encoding correctly.
    #
    # So first we have to force the correct encoding (ISO-8859-1) THEN change it
    # to UTF-8 which is what this site is using
    encoded_response = response.body.force_encoding(Encoding::ISO_8859_1).encode(Encoding::UTF_8)
    member_list = JSON.parse(encoded_response)['results']
    
    member_list.each do |import_member|
      puts "Importing #{import_member['member_id']} - #{import_member['name']} "
      m = ::Member.new
      m.meetup_id = import_member['member_id']
      m.name = import_member['name']
      m.bio = import_member['bio']
      m.photo_url = import_member['photo_url']
      m.save
    
    end
    
  end
  
end