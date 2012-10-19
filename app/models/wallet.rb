class Wallet < ActiveRecord::Base
  attr_accessible :money, :user_id

  belongs_to :user
end
