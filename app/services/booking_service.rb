# イベントへの申し込みロジックをカプセル化するサービス
class BookingService
  # コンストラクタ
  def initialize(event, user)
    @event = event
    @user = user
  end

  # 申し込み処理を実行する
  # @return [Hash] 成功・失敗の状態とメッセージを含むハッシュ
  def execute
    # 悲観的ロック(SELECT ... FOR UPDATE)を使用して同時実行時の整合性を保つ
    @event.with_lock do
      # 定員チェック
      if @event.full?
        return { success: false, message: I18n.t("activerecord.errors.models.booking.base.event_at_capacity") }
      end

      # 申し込み済みチェック
      if @event.booked_by?(@user)
        return { success: false, message: I18n.t("activerecord.errors.models.booking.attributes.user_id.taken") }
      end

      # 申し込みレコードの作成と保存
      booking = @event.bookings.build(user: @user)
      if booking.save
        { success: true, message: I18n.t("views.bookings.create.success") }
      else
        { success: false, message: I18n.t("views.bookings.create.failure") }
      end
    end
  rescue => e
    # 予期せぬエラーのキャッチ
    { success: false, message: I18n.t("common.errors.unexpected", error: e.message) }
  end
end
