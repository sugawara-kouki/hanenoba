module AdminUi
  class BadgeComponent < ApplicationComponent
    def initialize(status:)
      @status = status.to_sym
    end

    def label
      I18n.t("activerecord.attributes.user.status.#{@status}", default:
        I18n.t("activerecord.attributes.event.status/#{@status}", default: @status.to_s)
      )
    end

    def color_classes
      case @status
      when :published, :approved
        "bg-green-50 text-green-700 ring-green-600/20"
      when :draft, :pending
        "bg-yellow-50 text-yellow-700 ring-yellow-600/20"
      when :hidden
        "bg-gray-50 text-gray-700 ring-gray-600/20"
      else
        "bg-blue-50 text-blue-700 ring-blue-600/20"
      end
    end
  end
end
