class Admin::BookingsController < Admin::BaseController
  def destroy
    @booking = Booking.find(params[:id])
    @event = @booking.event
    @user = @booking.user
    
    @booking.destroy
    redirect_to admin_event_path(@event), notice: "ユーザー「#{@user.name || @user.email}」の申し込みを取り消しました。"
  end
end
