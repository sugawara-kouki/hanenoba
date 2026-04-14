module Layout
  class NavbarComponent < ViewComponent::Base
    def initialize(user:, admin_signed_in:, active_controller:)
      @user = user
      @admin_signed_in = admin_signed_in
      @active_controller = active_controller
    end

    private

    attr_reader :user, :admin_signed_in, :active_controller

    def user_signed_in?
      user.present?
    end

    def active_link?(controllers)
      Array(controllers).include?(active_controller)
    end

    def nav_link_classes(controllers)
      base = "text-base font-bold transition-all uppercase tracking-widest"
      if active_link?(controllers)
        "#{base} text-indigo-600"
      else
        "#{base} text-gray-400 hover:text-gray-900"
      end
    end
  end
end
