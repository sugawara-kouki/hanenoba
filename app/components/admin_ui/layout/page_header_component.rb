module AdminUi
  module Layout
    class PageHeaderComponent < ViewComponent::Base
      # タイトルの上に表示するコンテンツ（アイコンやバッジなど）のためのスロット
      renders_one :prepend
      # 右側のボタン等を入れるためのスロット
      renders_one :action

      def initialize(title:, subtitle: nil)
        @title = title
        @subtitle = subtitle
      end

      private

      attr_reader :title, :subtitle
    end
  end
end
