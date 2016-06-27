class Podcast < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include SearchablePodcast

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :thumbnail, PictureUploader
  has_many :episodes

  default_scope -> { order('created_at DESC') }

  def tags
    Episode.unscoped.
      where(podcast_id: self.id).
      joins(:tags).
      group('tags.name').
      select('tags.name , count(episodes.id) as count')
  end

  def self.tagged_with name
    tag_id =  "SELECT tags.id FROM tags WHERE (name = :name)  LIMIT 1"
    episode_ids = "SELECT DISTINCT(episode_id) FROM taggings where tag_id = (#{tag_id})"
    podcast_ids = "SELECT DISTINCT(podcast_id) FROM episodes where episodes.id in (#{episode_ids})"
    where("id in (#{podcast_ids})", name: name)
  end

  def self.include_episode_counts
    joins(
      %{ LEFT OUTER JOIN (
           SELECT e.podcast_id, count(*) as episodes_count
           FROM episodes e GROUP BY e.podcast_id) ep
           ON ep.podcast_id = podcasts.id }).
    select("COALESCE(ep.episodes_count,0) as episodes_count, podcasts.*")
  end

  def self.search_by_title(term)
    where('title like ?', "#{term}%")
  end

  def self.full_search(term)
    where('title like ?', "#{term}%")
  end

  #using sunspot ful-text search
  #searchable do
  #  text :title
  #  text :episodes do
  #    episodes.map { |episode| episode.title }
  #  end
  #end
end