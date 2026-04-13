# イベントへの申し込みロジックをカプセル化するサービス
class BookingService
  def initialize(event, user)
    @event = event
    @user = user
  end

  # 申し込み処理を実行する
  # @return [Hash] 成功・失敗の状態とメッセージを含むハッシュ
  def execute
    # 悲観的ロック(SELECT ... FOR UPDATE)を使用して同時実行時の整合性を保つ
    @event.with_lock do
      # 1. 定員チェック (Modelのメソッドを使用)
      if @event.full?
        return { success: false, message: I18n.t("activerecord.errors.models.booking.base.event_at_capacity", default: "定員に達しているため申し込みできません。") }
      end

      # 2. 申し込み済みチェック (Modelのメソッドを使用)
      if @event.booked_by?(@user)
        return { success: false, message: I18n.t("activerecord.errors.models.booking.attributes.user_id.taken", default: "既に申し込み済みです。") }
      end

      # 3. 申し込みレコードの作成と保存
      booking = @event.bookings.build(user: @user)
      if booking.save
        { success: true, message: I18n.t("bookings.create.success", default: "申し込みが完了しました！") }
      else
        { success: false, message: I18n.t("bookings.create.failure", default: "申し込みに失敗しました。") }
      end
    end
  rescue => e
    # 予期せぬエラーのキャッチ
    { success: false, message: I18n.t("common.errors.unexpected", default: "エラーが発生しました: %{error}", error: e.message) }
  end
end
