class User < ActiveRecord::Base
  has_many :problems
  has_many :solutions
  has_many :user_badges
  has_many :badges ,through: :user_badges
  has_many :user_infos

  def get key
    info = UserInfo.find_by user_id: id, category: key
    return info.value unless info.nil?
  end

  def set key, value
    info = UserInfo.find_or_create_by user_id: id, category: key
    info.value = value
    info.save!
  end

  def get key, defval
    info = UserInfo.find_by user_id: id, category: key
    if info == nil
      set key defval
    end
    return UserInfo.find_by user_id: id, category: key
  end
  
end
