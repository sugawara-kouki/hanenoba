# 複数のイベントに対して一括で申し込みを行うサービス
class BulkBookingService
  def initialize(event_ids, user, admin_mode: false)
    @event_ids = event_ids
    @user = user
    @admin_mode = admin_mode
  end

  # 一括申し込み処理を実行する
  # @return [Hash] 成功件数、成功タイトル、失敗メッセージを含むハッシュ
  def execute
    # イベントが選択されていない場合のガード
    return { success: false, message: I18n.t("views.bookings.bulk_create.no_events") } if @event_ids.empty?

    success_titles = []
    failure_messages = []

    # 管理者モードなら全てのイベントを対象とし、一般ユーザーなら公開済みのみを対象とする
    base_scope = @admin_mode ? Event.all : Event.published
    events = base_scope.where(id: @event_ids)
    events.each do |event|
      # 各イベントの申し込みは BookingService に委譲
      result = BookingService.new(event, @user).execute

      # XSS対策のため、イベント名はエスケープして保持する
      safe_title = ERB::Util.html_escape(event.title)
      if result[:success]
        success_titles << safe_title
      else
        # 失敗時はエラーメッセージを蓄積
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
