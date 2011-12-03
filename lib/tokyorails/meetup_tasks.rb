module MeetupTasks
  
  def self.import_members

    meetup_member_list = get_members_list   
    meetup_member_list.each do |meetup_member|

      member = Member.where(:meetup_id => meetup_member['member_id']).first

      if member.nil?
        update_member(Member.new, meetup_member)
      else
        # Meetups API doesn't use proper unix time, they use milliseconds
        # instead so we need to divide by 1000 before converting
        update_member(member, meetup_member) if member.updated_at < Time.zone.at((meetup_member['updated'].to_i / 1000))
      end
    end    
  end

  protected

  def self.update_member(record, data)
      record.meetup_id = data['member_id']
      record.name = data['name']
      record.bio = data['bio']
      record.photo_url = data['photo_url']
      record.github_username = get_github_username(data['additional'])
      record.save    
  end

  def self.get_members_list
    
    uri = URI('https://api.meetup.com/2/profiles.json')
    uri.query = URI.encode_www_form( { :key => Rails.application.config.meetup_com_api_key, :page => 200, :group_id => '2270561'})
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    response = http.start {|http| http.request(request) }

    # Due to this issue: http://redmine.ruby-lang.org/issues/2567 net/http does
    # not detect the meetup response encoding correctly so it buggers up the
    # character encoding of some of our nordicly-named members.
    #
    # So first we have to force the correct encoding (ISO-8859-1) THEN change it
    # to UTF-8 which is what this site is using.
    encoded_response = response.body.force_encoding(Encoding::ISO_8859_1).encode(Encoding::UTF_8)
    JSON.parse(encoded_response)['results']
    
  end

  def self.get_github_username(data)
      match = /github:([^\s]*)/.match(data)

      # Return the first match if there is one, otherwise nil
      match ? match[1] : nil    
  end 
end