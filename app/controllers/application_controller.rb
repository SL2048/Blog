class ApplicationController < ActionController::API
  before_action :authenticate_user!

  protected

  def pagination_data(objects)
    {
      current_page: objects.current_page,
      next_page: objects.next_page,
      prev_page: objects.previous_page,
      total_pages: objects.total_pages,
      total_count: objects.total_entries
    }
  end

end
