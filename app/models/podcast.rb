class Podcast < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :thumbnail, PictureUploader
  has_many :episodes

  default_scope -> { order('created_at DESC') }

  def tags
    Episode.unscoped.
      where(podcast_id: 9).
      joins(:tags).
      group('tags.name').
      select('tags.name , count(episodes.id) as count')
  end

  def self.include_episode_counts
    joins(
      %{ LEFT OUTER JOIN (
           SELECT e.podcast_id, count(*) as episodes_count
           FROM episodes e GROUP BY e.podcast_id) ep
           ON ep.podcast_id = podcasts.id }).
    select("COALESCE(ep.episodes_count,0) as episodes_count, podcasts.*")
  end

  def self.search(term)
  where('title like ?', "#{term}%")
  end
end
