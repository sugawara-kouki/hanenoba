class EventsController < ApplicationController
  # LINE認証を必須にする（管理者の場合はスキップ可能にする）
  before_action :authenticate_user!, unless: -> { admin_signed_in? }

  def index
    base_scope = admin_signed_in? ? Event.all : Event.published
    @events = base_scope.includes(:event_type)
                   .with_bookings_count
                   .title_like(params[:q])
                   .held_on(params[:date])
                   .with_remaining_capacity(params[:capacity])
                   .order(held_at: :asc)

    @pagy, @events = pagy(@events, limit: 12)
  end

  def show
    @event = admin_signed_in? ? Event.find(params[:id]) : Event.published.find(params[:id])
    @is_booked = user_signed_in? && @event.bookings.exists?(user: current_user)
  end
end
