class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "は既にこのイベントに申し込んでいます" }
  validate :event_at_capacity, on: :create

  private

  def event_at_capacity
    if event.present? && event.full?
      errors.add(:base, "定員に達しているため申し込みできません")
    end
  end
end
