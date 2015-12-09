class Revision < ActiveRecord::Base
  has_many :executions
end
