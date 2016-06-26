class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:dashboard]
  respond_to :html, :js

  def index
    @tags  = Tag.usage
    @podcasts = Podcast.include_episode_counts
    @podcasts = Podcast.search(params[:search]).records               unless  params[:search].blank?
    @podcasts = @podcasts.tagged_with(params[:tag])                   unless  params[:tag].blank?

    @podcasts = @podcasts.paginate(page: params[:page], per_page: 4)

  end

  def show
    @full = params[:full] #rendering full view in container
    @tag = params[:tag]

    @possible_tags = Episode.where(podcast_id: @podcast)

    if @tag.blank? #filtering by tag
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

