class EpisodesController < ApplicationController
  before_action :authenticate_podcast!, except: [:show]
  before_action :require_permission, except: [:show]
  before_action :find_podcast
  before_action :find_episode,  only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def new
    @episode  = @podcast.episodes.new
  end

  def create
    @episode  = @podcast.episodes.new episode_params
    if @episode.save
      redirect_to podcast_episode_path(@podcast, @episode)
    else
      render 'new'
    end
  end

  def show
    @episodes = Episode.where(podcast_id: @podcast)
                       .where.not(id: @episode.id )
                       .limit(6)
                       .paginate(page: params[:page], per_page: 6)
  end

  def edit
  end

  def update
    if @episode.update episode_params
      redirect_to podcast_episode_path(@podcast, @episode),
                  notice: 'Episode was succesfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @episode.destroy
    redirect_to root_path
  end

  private
    def find_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    def find_episode
      @episode = Episode.includes(:tags).find(params[:id])
    end

    def episode_params
      params.require(:episode).permit(:title, :description, :episode_thumbnail, :mp3, :all_tags)
    end

    def require_permission
      @podcast = Podcast.find(params[:podcast_id])
      if current_podcast != @podcast
        redirect_to root_path, notice: 'You are nnot allowed to do this!'
      end
    end
end
