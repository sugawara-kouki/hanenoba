class Admin::EventTypesController < Admin::BaseController
  include AdminSortable
  before_action :set_event_type, only: %i[ edit update destroy ]

  # GET /event_types or /event_types.json
  def index
    s = sort_params("created_at", "desc", %w[name created_at])
    @event_types = EventType.all.order("#{s[:column]} #{s[:direction]}")
  end


  # GET /event_types/new
  def new
    @event_type = EventType.new
  end

  # GET /event_types/1/edit
  def edit
  end

  # POST /event_types or /event_types.json
  def create
    @event_type = EventType.new(event_type_params)

    if @event_type.save
      redirect_to admin_event_types_path, notice: t("admin.notices.created", model: EventType.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_types/1 or /event_types/1.json
  def update
    if @event_type.update(event_type_params)
      redirect_to admin_event_types_path, notice: t("admin.notices.updated", model: EventType.model_name.human), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /event_types/1 or /event_types/1.json
  def destroy
    @event_type.destroy!

    respond_to do |format|
      format.html { redirect_to admin_event_types_path, notice: t("admin.notices.destroyed", model: EventType.model_name.human), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_type
      @event_type = EventType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_type_params
      params.expect(event_type: [ :name ])
    end
end
