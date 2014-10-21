class Moviegoer < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  def self.create_with_omniauth(auth)
  	Moviegoer.create!(
  		:provider => auth["provider"],
  		:uid => auth["uid"],
  		:name => auth["info"]["name"]
  	)
  end
  
  has_many :reviews, :dependent => :destroy
  has_many :movies, :through => :reviews
end
