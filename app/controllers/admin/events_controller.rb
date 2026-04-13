class Admin::EventsController < Admin::BaseController
  include AdminSortable
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    s = sort_params("held_at", "desc", %w[title held_at created_at capacity status])
    @pagy, @events = pagy(:offset, Event.includes(:event_type).order("#{s[:column]} #{s[:direction]}"), limit: 1)
  end

  # GET /events/1 or /events/1.json
  def show
    @bookings = @event.bookings.includes(:user).order(created_at: :desc)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to [ :admin, @event ], notice: t("admin.notices.created", model: Event.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    if @event.update(event_params)
      redirect_to [ :admin, @event ], notice: t("admin.notices.updated", model: Event.model_name.human), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!
    redirect_to admin_events_path, notice: t("admin.notices.destroyed", model: Event.model_name.human), status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.expect(event: [ :title, :event_type_id, :capacity, :held_at, :location, :status ])
    end
end
