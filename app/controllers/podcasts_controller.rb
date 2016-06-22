class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:show, :dashboard]

  def index
    @podcasts = Podcast.all
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
    @episodes = Episode.where(podcast_id: @podcast)
  end
end
