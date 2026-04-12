class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.published.find(params[:event_id])
    
    # 悲観的ロックを用いて、定員チェックと保存を同一トランザクション内で行う
    @event.with_lock do
      if @event.bookings.count >= @event.capacity
        redirect_to event_path(@event), alert: "申し訳ありません。定員に達したため申し込みできません。"
        return
      end

      if @event.bookings.exists?(user: current_user)
        redirect_to event_path(@event), alert: "既に申し込み済みです。"
        return
      end

      @booking = @event.bookings.build(user: current_user)
      if @booking.save
        redirect_to event_path(@event), notice: "申し込みが完了しました！"
      else
        redirect_to event_path(@event), alert: "申し込みに失敗しました。"
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "指定されたイベントは見つかりませんでした。"
  end
end
