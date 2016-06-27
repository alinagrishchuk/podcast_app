class SeacrchController < ApplicationController
  respond_to :html, :js

  def episodes
    if params[:search].blank?
      @episodes = Episode.all.
        paginate(page: params[:page], per_page: 6)
    else
      @episodes = Episode.search_with_highlight(params[:search]).
        paginate(page: params[:page], per_page: 4)
    end
  end
end
