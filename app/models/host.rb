class Host < ActiveRecord::Base
  has_many :host_executions

  has_many :executions, through: :host_executions
end
