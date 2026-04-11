class EventsController < ApplicationController
  # LINE認証を必須にする
  before_action :authenticate_user!

  def index
    @events = Event.all
  end
end
