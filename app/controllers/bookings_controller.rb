# 予約（申し込み）機能を制御するコントローラー
# 複雑なビジネスロジックは Service Object (app/services) に委譲し、
# コントローラーは画面遷移と通知(Flash)の設定のみを担当する（Skinny Controller）
class BookingsController < ApplicationController
  before_action :authenticate_user!

  # 1件の申し込みを作成
  def create
    @event = Event.published.find(params[:event_id])

    # 申し込みロジックの実行をサービスに委譲
    result = BookingService.new(@event, current_user).execute

    if result[:success]
      redirect_to event_path(@event), notice: result[:message]
    else
      redirect_to event_path(@event), alert: result[:message]
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: I18n.t("errors.messages.event_not_found", default: "指定されたイベントは見つかりませんでした。")
  end

  # 複数のイベントに対して一括で申し込む
  def bulk_create
    # 一括申し込みロジックの実行をサービスに委譲
    result = BulkBookingService.new(params[:event_ids] || [], current_user).execute

    # 成功メッセージの設定（複数タイトルの表示に対応）
    if result[:success]
      flash[:notice] = "#{result[:success_count]} 件の申し込みに成功しました！ (#{result[:success_titles].join('、')})"
    end

    # 失敗メッセージの設定（改行を含むHTMLとして表示）
    if result[:failure_messages].any?
      flash[:alert] = result[:failure_messages].join("<br>").html_safe
    end

    redirect_to events_path
  end
end
