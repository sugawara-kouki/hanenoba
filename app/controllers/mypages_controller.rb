class MypagesController < ApplicationController
  before_action :authenticate_user!

  def calendar
    # 表示する月の基準日（デフォルトは今日）
    @base_date = params[:date]&.to_date || Date.today
    @start_date = @base_date.beginning_of_month.beginning_of_week(:sunday)
    @end_date = @base_date.end_of_month.end_of_week(:sunday)

    # ユーザーが申し込んでいるイベントを取得
    @booked_events = current_user.booked_events.where(held_at: @start_date..@end_date.end_of_day)

    # 日付ごとのマップを作成
    @events_by_date = @booked_events.group_by { |e| e.held_at.to_date }
  end
end
