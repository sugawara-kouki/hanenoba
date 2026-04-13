class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # 同一ユーザーが同じイベントに複数回申し込むのを防ぐ
  validates :user_id, uniqueness: { scope: :event_id, message: "は既にこのイベントに申し込んでいます" }
  
  # 保存前に定員チェックを実行
  validate :event_at_capacity, on: :create

  private

  # イベントが定員に達している場合にバリデーションエラーを追加する
  def event_at_capacity
    if event.present? && event.full?
      errors.add(:base, "定員に達しているため申し込みできません")
    end
  end
end
