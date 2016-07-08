class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show, :dashboard]
  before_action :find_episode, only: [:dashboard]
  before_action :set_tag, only: [:index, :show]

  respond_to :html, :js

  def index
    @tags  = Tag.usage
    if params[:search].blank?
      @podcasts = Podcast.all
      @podcasts = @podcasts.tagged_with @tag unless @tag.blank?
    else #search using just es
      @podcasts = Podcast.search(params[:search]).paginate(page: params[:page], per_page: 4).records
    end

    @podcasts = @podcasts.include_episodes_count.paginate(page: params[:page], per_page: 4)
  end

  def show
    @full = params[:full] #rendering full view in container

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

  def set_tag
    @tag = params[:tag]
  end
end

