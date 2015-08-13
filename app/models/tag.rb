class Tag < ActiveRecord::Base
  belongs_to :target, polymorphic: true
end
