class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [ :line ]

  has_many :bookings, dependent: :destroy
  has_many :booked_events, through: :bookings, source: :event

  # 承認済みチェック
  def active_for_authentication?
    super && approved?
  end

  # 未承認時のメッセージ
  def inactive_message
    approved? ? super : :not_approved
  end

  # LINEの認証情報からユーザーを検索または作成
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |u|
      u.approved = false # 新規ユーザーのみ未承認で初期化
    end

    user.name = auth.info.name
    user.image = auth.info.image
    user.save if user.changed?
    user
  end
end
