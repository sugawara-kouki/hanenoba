module AdminUI
  module Layout
    class BreadcrumbsComponent < ViewComponent::Base
      def initialize(breadcrumbs:)
        @breadcrumbs = breadcrumbs
      end

      private

      attr_reader :breadcrumbs
    end
  end
end
