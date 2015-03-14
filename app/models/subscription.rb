class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  validates_uniqueness_of :user_id, scope: :channel_id
end
