module AdminSortable
  extend ActiveSupport::Concern

  included do
    private

    def sort_params(default_column, default_direction = "desc", allowed_columns = [])
      sort = params[:sort] || default_column
      direction = params[:direction] || default_direction
      
      sort = default_column unless allowed_columns.include?(sort)
      direction = default_direction unless %w[asc desc].include?(direction)
      
      { column: sort, direction: direction }
    end
  end
end
