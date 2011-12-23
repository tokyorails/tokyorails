# -*- encoding : utf-8 -*-
class AddAccessTokenToMember < ActiveRecord::Migration
  def change
    add_column :members, :access_token, :string
  end
end
