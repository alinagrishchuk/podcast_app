class SearchController < ApplicationController
  respond_to :html, :js

  def episodes
    params[:search]  ||= 'actually vinyl'
    unless params[:search].blank?
      @episodes = Episode.search_with_highlight(params[:search]).
        paginate(page: params[:page], per_page: 4)
    end
  end

  def autocomplete_podcasts
    search = params[:search] || "*"
    render json: Podcast.search(search, fields: [{title: :text_middle}], limit: 3).map(&:title)
  end
end

