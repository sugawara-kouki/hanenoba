class Admin::DashboardController < Admin::BaseController
  def show
    @total_events = Event.count
    @total_bookings = Booking.count
    @total_users = User.count

    # 最近の申込5件
    @recent_bookings = Booking.includes(:user, :event).order(created_at: :desc).limit(5)

    # 今後のイベント3件 (N+1解消のため with_bookings_count を使用)
    @upcoming_events = Event.includes(:event_type)
                           .with_bookings_count
                           .where("held_at >= ?", Time.current)
                           .order(held_at: :asc)
                           .limit(3)
    @pending_users_count = User.where(approved: false).count
  end
end
