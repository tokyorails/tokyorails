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

  def thumbnail_class(index)
    if (index + 1) % 7 == 0
      'thumbnail popover-left'
    else
      'thumbnail popover-right'
    end
  end
end
