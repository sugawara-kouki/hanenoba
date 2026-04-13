class BookingService
  def initialize(event, user)
    @event = event
    @user = user
  end

  def execute
    @event.with_lock do
      if @event.full?
        return { success: false, message: I18n.t('activerecord.errors.models.booking.base.event_at_capacity', default: "定員に達しているため申し込みできません。") }
      end

      if @event.booked_by?(@user)
        return { success: false, message: I18n.t('activerecord.errors.models.booking.attributes.user_id.taken', default: "既に申し込み済みです。") }
      end

      booking = @event.bookings.build(user: @user)
      if booking.save
        { success: true, message: I18n.t('bookings.create.success', default: "申し込みが完了しました！") }
      else
        { success: false, message: I18n.t('bookings.create.failure', default: "申し込みに失敗しました。") }
      end
    end
  rescue => e
    { success: false, message: I18n.t('common.errors.unexpected', default: "エラーが発生しました: %{error}", error: e.message) }
  end
end
