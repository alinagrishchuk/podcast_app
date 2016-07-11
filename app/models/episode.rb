class Episode < ActiveRecord::Base
  include SearchableEpisodes

  default_scope -> { includes(:tags).order('created_at DESC') }

  belongs_to :podcast

  has_many :taggings
  has_many :tags, through: :taggings

  mount_uploader :episode_thumbnail, PictureUploader
  has_attached_file     :mp3,
                        :storage => :dropbox,
                        :dropbox_credentials => Rails.root.join('config/dropbox.yml'),
                        :path => "episodes/mp3/:id/:id_:filename"

  validates_attachment  :mp3,
                        :content_type => { :content_type => ["audio/mpeg", "audio/mp3"] },
                        :file_name => { :matches => [/mp3\Z/] }
  validates :podcast, presence: true

  def all_tags=(tags_string)
    self.tags = tags_string.split(',').map do |t|
      Tag.where(name: t.downcase.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def self.tagged_with(name)
    Tag.find_by(name: name).try(:episodes) || []
  end

end
