# -*- encoding : utf-8 -*-
module MembersHelper
  def join_interests(member)
    member.interests.map { |interest| interest }.join '  |  '
  end
  
  def projects(member)
    if member.github_projects.empty?
      []
    else
     data = member.github_projects.body
     projects = JSON.parse(data)
   end
  end
  
end
