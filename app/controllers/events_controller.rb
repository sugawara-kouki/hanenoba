class EventsController < ApplicationController
  # LINE認証を必須にする
  before_action :authenticate_user!

  def index
    @events = Event.published.includes(:event_type)
                   .with_bookings_count
                   .title_like(params[:q])
                   .held_on(params[:date])
                   .with_remaining_capacity(params[:capacity])
                   .order(held_at: :asc)

    @pagy, @events = pagy(@events, limit: 12)
  end

  def show
    @event = Event.published.find(params[:id])
    @is_booked = @event.bookings.exists?(user: current_user)
  end
end
