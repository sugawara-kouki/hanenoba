class BulkBookingService
  def initialize(event_ids, user)
    @event_ids = event_ids
    @user = user
  end

  def execute
    return { success: false, message: I18n.t('bookings.bulk_create.no_events', default: "イベントが選択されていません。") } if @event_ids.empty?

    success_titles = []
    failure_messages = []

    events = Event.published.where(id: @event_ids)
    events.each do |event|
      result = BookingService.new(event, @user).execute
      safe_title = ERB::Util.html_escape(event.title)
      if result[:success]
        success_titles << safe_title
      else
        failure_messages << "【#{safe_title}】#{ERB::Util.html_escape(result[:message])}"
      end
    end

    {
      success: success_titles.any?,
      success_count: success_titles.count,
      success_titles: success_titles,
      failure_messages: failure_messages
    }
  end
end
