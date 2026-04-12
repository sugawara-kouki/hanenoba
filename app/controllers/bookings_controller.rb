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

  def bulk_create
    event_ids = params[:event_ids] || []
    
    if event_ids.empty?
      redirect_to events_path, alert: "イベントが選択されていません。"
      return
    end

    success_titles = []
    failure_messages = []

    Event.published.where(id: event_ids).each do |event|
      begin
        event.with_lock do
          if event.bookings.count >= event.capacity
            failure_messages << "【#{event.title}】満員のため申し込めませんでした。"
          elsif event.bookings.exists?(user: current_user)
            # 一括申し込み時は既に申し込んでいるものは静かにスキップするか、メッセージを出す
            # 今回はメッセージを出す
            failure_messages << "【#{event.title}】既に申し込み済みです。"
          else
            booking = event.bookings.build(user: current_user)
            if booking.save
              success_titles << event.title
            else
              failure_messages << "【#{event.title}】保存に失敗しました。"
            end
          end
        end
      rescue => e
        failure_messages << "【#{event.title}】エラーが発生しました (#{e.message})"
      end
    end

    flash[:notice] = "#{success_titles.count} 件の申し込みに成功しました！ (#{success_titles.join('、')})" if success_titles.any?
    flash[:alert] = failure_messages.join("<br>").html_safe if failure_messages.any?

    redirect_to events_path
  end
end
