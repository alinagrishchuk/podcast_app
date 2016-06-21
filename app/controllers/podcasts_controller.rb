class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show]
  def index
    @podcasts = Podcast.all
  end
  def show
    @podcast
  end

  private

  def find_podcast
      @podcast = Podcast.find(params[:id])
  end
end
