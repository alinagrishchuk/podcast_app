class Podcast < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :thumbnail,
                    styles: { large: '300x300#',
                              medium: '200x200#' },
                    :convert_options => { :thumb => '-quality 75 -strip' },
                    :storage => :dropbox,
                    :dropbox_credentials => { app_key: ENV['APP_KEY'],
                                              app_secret: ENV['APP_SECRET'],
                                              access_token: ENV['ACCESS_TOKEN'],
                                              access_token_secret: ENV['ACCESS_TOKEN_SECRET'],
                                              user_id: ENV['USER_ID'],
                                              access_type: 'app_folder'},
                    :path => "podcasts/:id/:style/:id_:filename"

  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\Z/
  has_many :episodes

  default_scope -> { order('created_at DESC') }

  def self.include_episode_counts
    joins(
      %{ LEFT OUTER JOIN (
           SELECT e.podcast_id, count(*) as episodes_count
           FROM episodes e GROUP BY e.podcast_id) ep
           ON ep.podcast_id = podcasts.id }).
    select("COALESCE(ep.episodes_count,0) as episodes_count, podcasts.*")
  end
end
