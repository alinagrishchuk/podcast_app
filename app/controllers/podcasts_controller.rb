class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:dashboard]
  respond_to :html, :js

  def index
    if params[:search].present?
      #@search = Podcast.search { fulltext params[:search]; paginate :page => params[:page] }
      #@podcasts = @search.results
      @podcasts = Podcast.search(params[:search]).page(params[:page]).records
        #records.paginate(page: params[:page], per_page: 4)
    else
      @podcasts = Podcast.include_episode_counts
      @podcasts =  @podcasts.search(params[:search]) if params[:search].present?
      @podcasts =  @podcasts.paginate(page: params[:page], per_page: 4)
    end

  end

  def show
    @full = params[:full]
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

