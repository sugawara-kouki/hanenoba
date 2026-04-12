class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "は既にこのイベントに申し込んでいます" }
end
