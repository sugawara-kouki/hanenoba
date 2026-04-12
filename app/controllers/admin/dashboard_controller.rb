class Admin::DashboardController < Admin::BaseController
  def show
    @total_events = Event.count
    @total_bookings = Booking.count
    @total_users = User.count
    
    # 最近の申込5件
    @recent_bookings = Booking.includes(:user, :event).order(created_at: :desc).limit(5)
    
    # 今後のイベント3件
    @upcoming_events = Event.where("held_at >= ?", Time.current).order(held_at: :asc).limit(3)
  end
end
