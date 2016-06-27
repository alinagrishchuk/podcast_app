class SeacrchController < ApplicationController
  def episodes
    if params[:q].blank?
      @episodes = Episode.all
    else
      @episodes = Episode.seacrh_with_highlight(params[:q]).results
    end
  end
end
