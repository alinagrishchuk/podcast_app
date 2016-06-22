class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_attached_file :episode_thumbnail, styles: { large: "1000x1000#", medium: "550x550#" }
  validates_attachment_content_type :episode_thumbnail, content_type: /\Aimage\/.*\Z/

  validates :podcast, presence: true

  default_scope -> { order('created_at DESC') }
end
