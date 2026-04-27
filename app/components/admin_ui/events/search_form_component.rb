module AdminUi
  module Events
    class SearchFormComponent < ApplicationComponent
      def initialize(params:)
        @params = params
      end

      private

      # フォームの値を保持するためのヘルパー関数
      def q_value
        @params[:q]
      end

      def date_value
        @params[:date]
      end

      def status_value
        @params[:status]
      end

      def capacity_value
        @params[:capacity]
      end

      # ステータスの選択肢を作成
      def status_options
        Event.statuses.keys.map { |k| [ Event.new(status: k).status_ja, k ] }
      end
    end
  end
end
