# -*- encoding : utf-8 -*-
module MembersHelper
  def join_interests(member)
    member.interests.map { |interest| interest }.join '  |  '
  end
end
