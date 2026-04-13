class Admin::BookingsController < Admin::BaseController
  def destroy
    @booking = Booking.find(params[:id])
    @event = @booking.event
    @user = @booking.user

    @booking.destroy
    redirect_to admin_event_path(@event), notice: t("admin.notices.booking_cancelled", name: @user.name || @user.email)
  end
end
