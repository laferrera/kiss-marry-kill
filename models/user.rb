class User < ActiveRecord::Base

  def as_json(option)
    super(:only => [:name, :id, :game_id]).merge({avatar_url: avatar_url})
    
  end

  def avatar_url
    avatar_index = self.name.bytes.sum % 28
    "/assets/img/blobs/#{avatar_index}.gif"
  end
end