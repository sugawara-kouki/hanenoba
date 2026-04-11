class EventsController < ApplicationController
  # LINE認証を必須にする
  before_action :authenticate_user!

  def index
    @events = Event.published.includes(:event_type).order(held_at: :asc)
  end
end
