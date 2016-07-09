class Episode < ActiveRecord::Base
  include SearchableEpisodes

  belongs_to :podcast
  has_many :taggings
  has_many :tags, through: :taggings
  mount_uploader :episode_thumbnail, PictureUploader
  has_attached_file     :mp3,
                        :storage => :dropbox,
                        :dropbox_credentials => { app_key: ENV['APP_KEY'],
                                                  app_secret: ENV['APP_SECRET'],
                                                  access_token: ENV['ACCESS_TOKEN'],
                                                  access_token_secret: ENV['ACCESS_TOKEN_SECRET'],
                                                  user_id: ENV['USER_ID'],
                                                  access_type: 'app_folder'},
                        :path => "episodes/mp3/:id/:id_:filename"

  validates_attachment  :mp3,
                        :content_type => { :content_type => ["audio/mpeg", "audio/mp3"] },
                        :file_name => { :matches => [/mp3\Z/] }
  validates :podcast, presence: true

  default_scope -> { includes(:tags) }

  def all_tags=(tags_string)
    self.tags = tags_string.split(',').map do |t|
      Tag.where(name: t.downcase.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  default_scope -> { order('created_at DESC') }

  def self.tagged_with(name)
    Tag.find_by(name: name).episodes
  end

end
