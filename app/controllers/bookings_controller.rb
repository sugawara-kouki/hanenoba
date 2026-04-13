class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.published.find(params[:event_id])
    result = BookingService.new(@event, current_user).execute

    if result[:success]
      redirect_to event_path(@event), notice: result[:message]
    else
      redirect_to event_path(@event), alert: result[:message]
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: I18n.t('errors.messages.event_not_found', default: "指定されたイベントは見つかりませんでした。")
  end

  def bulk_create
    result = BulkBookingService.new(params[:event_ids] || [], current_user).execute

    if result[:success]
      flash[:notice] = "#{result[:success_count]} 件の申し込みに成功しました！ (#{result[:success_titles].join('、')})"
    end

    if result[:failure_messages].any?
      flash[:alert] = result[:failure_messages].join("<br>").html_safe
    end

    redirect_to events_path
  end
end
