class SearchController < ApplicationController
  respond_to :html, :js

  def episodes
    unless params[:search].blank?
      @episodes = Episode.search_with_highlight(params[:search]).
        paginate(page: params[:page], per_page: 4)
    end
  end
end
