module AdminUi
  module Layout
    class BreadcrumbsComponent < ApplicationComponent
      def initialize(breadcrumbs:)
        @breadcrumbs = breadcrumbs
      end

      private

      attr_reader :breadcrumbs
    end
  end
end
