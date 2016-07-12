class Podcast < ActiveRecord::Base
  default_scope -> { order('podcasts.created_at DESC') }

  has_many :episodes, dependent: :destroy

  validates :title,     presence: true
  validates :itunes,    url: true, allow_blank: true
  validates :stitcher,  url: true, allow_blank: true
  validates :podbay,    url: true, allow_blank: true

  searchkick text_middle: [:title], autocomplete: ['title'], searchable: ['title']
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :thumbnail, PictureUploader

  def search_data
    as_json only: [:title]
  end

  def tags
    Tag.usage.where("episodes.podcast_id = #{self.id}")
  end

  def self.tagged_with name
    tag_id =  "SELECT tags.id FROM tags WHERE (name = :name)  LIMIT 1"
    episode_ids = "SELECT DISTINCT(episode_id) FROM taggings where tag_id = (#{tag_id})"
    podcast_ids = "SELECT DISTINCT(podcast_id) FROM episodes where episodes.id in (#{episode_ids})"
    where("id in (#{podcast_ids})", name: name)
  end

  def self.include_episodes_count_old
    joins(
      %{ LEFT OUTER JOIN (
           SELECT e.podcast_id, count(*) as episodes_count
           FROM episodes e GROUP BY e.podcast_id) ep
           ON ep.podcast_id = podcasts.id }).
    select("COALESCE(ep.episodes_count,0) as episodes_count, podcasts.*")
  end

  def self.include_episodes_count
    joins(
      %{ LEFT OUTER JOIN ( #{Episode.grouped_by_podcast.to_sql} ) ep
           ON ep.podcast_id = podcasts.id }).
      select("COALESCE(ep.count_all,0) as episodes_count, podcasts.*")
  end
end