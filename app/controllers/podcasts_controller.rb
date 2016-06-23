class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:show, :dashboard]
  respond_to :html, :js

  def index
    @podcasts = Podcast.include_episode_counts.paginate(page: params[:page], per_page: 4)
  end

  def show
  end

  def dashboard
  end

  private

  def find_podcast
    @podcast = if params[:id].nil?
                 current_podcast
               else
                 Podcast.find(params[:id])
               end
  end

  def find_episode
    @episodes = Episode.where(podcast_id: @podcast).all.paginate(page: params[:page], per_page: 4)
  end
end
