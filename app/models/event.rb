class Event < ApplicationRecord
  belongs_to :event_type
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings

  enum :status, { draft: 0, published: 1, hidden: 2 }, default: :draft

  validates :title, presence: true
  validates :held_at, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :status, presence: true
  validates :event_type_id, presence: true

  def status_ja
    I18n.t("activerecord.attributes.event.status/#{status}", default: status)
  end

  def full?
    bookings.count >= capacity
  end

  def occupancy_rate
    return 0 if capacity.zero?
    (bookings.count.to_f / capacity * 100).round
  end

  def remaining_capacity
    [capacity - bookings.count, 0].max
  end

  def booked_by?(user)
    return false unless user
    bookings.exists?(user: user)
  end
end
