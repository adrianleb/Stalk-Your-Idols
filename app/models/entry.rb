class Entry < ActiveRecord::Base
  attr_accessible :name, :uniqueid
  validates_presence_of :name, :on => :create, :message => "empty name!"  
  validates_presence_of :uniqueid, :on => :create, :message => "Artist not valid, try again!"

end
