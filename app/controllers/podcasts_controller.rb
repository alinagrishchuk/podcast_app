class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:dashboard]
  respond_to :html, :js

  def index
    @podcasts = Podcast.include_episode_counts.paginate(page: params[:page], per_page: 4)
  end

  def show
    @tag = params[:tag]
    if @tag.blank?
      @episodes = Episode.where(podcast_id: @podcast).all.paginate(page: params[:page], per_page: 4)
    else
      @episodes = Episode.tagged_with(params[:tag]).where(podcast_id: @podcast).all.paginate(page: params[:page], per_page: 4)
    end
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
