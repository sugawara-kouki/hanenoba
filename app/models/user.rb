class User < ApplicationRecord
  # :validatable を削除しました
  devise :database_authenticatable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [ :line ]

  has_many :bookings, dependent: :destroy
  has_many :booked_events, through: :bookings, source: :event

  # 承認済みチェック（既存）
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  # ==========================================
  # SSO（LINEログイン）向けにカスタマイズ
  # ==========================================

  # パスワードを不要にする（パスワードが設定されている場合、またはSSOでない場合のみ必須にする）
  def password_required?
    return false if uid.present? # LINE IDがあればパスワードは不要
    super if defined?(super)
  end

  # メールアドレスを不要にする
  def email_required?
    false
  end

  # メールアドレスが入力された場合のみ、フォーマットチェックなどを行いたい場合はここにバリデーションを書きます
  validates :email, uniqueness: true, allow_blank: true, format: { with: Devise.email_regexp }, if: :email_changed?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.image = auth.info.image
      # メールアドレスは空で保存 ( 後のバリデーションで弾かれないように )
      user.approved = false
    end
  end
end
