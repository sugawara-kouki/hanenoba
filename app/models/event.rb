class Event < ApplicationRecord
  belongs_to :event_type
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings

  # イベントの公開状態を管理
  # draft: 下書き (管理者のみ), published: 公開 (一般ユーザー閲覧可), hidden: 非公開 (管理用)
  enum :status, { draft: 0, published: 1, hidden: 2 }, default: :draft

  validates :title, presence: true
  validates :held_at, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :status, presence: true
  validates :event_type_id, presence: true

  # ステータスの日本語名を翻訳ファイル(ja.yml)から取得
  def status_ja
    I18n.t("activerecord.attributes.event.status/#{status}", default: status)
  end

  # 定員に達しているかどうかを判定
  def full?
    bookings.count >= capacity
  end

  # 現在の予約充足率（パーセント）を計算
  def occupancy_rate
    return 0 if capacity.zero?
    (bookings.count.to_f / capacity * 100).round
  end

  # 残りの予約可能枠数を取得
  def remaining_capacity
    [ capacity - bookings.count, 0 ].max
  end

  # 特定のユーザーが既にこのイベントに申し込んでいるかチェック
  def booked_by?(user)
    return false unless user
    bookings.exists?(user: user)
  end
end
