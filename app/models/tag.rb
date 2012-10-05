class Tag < ActiveRecord::Base
  belongs_to :upload
  attr_accessible :name
end
