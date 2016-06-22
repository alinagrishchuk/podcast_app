class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_attached_file :episode_thumbnail, styles: { large: "1000x1000#", medium: "550x550#" },
                    :storage => :dropbox,
                    :dropbox_credentials => { app_key: ENV['APP_KEY'],
                                              app_secret: ENV['APP_SECRET'],
                                              access_token: ENV['ACCESS_TOKEN'],
                                              access_token_secret: ENV['ACCESS_TOKEN_SECRET'],
                                              user_id: ENV['USER_ID'],
                                              access_type: 'app_folder'},
                    :path => "episodes/:id/:style/:id_:filename"

  validates_attachment_content_type :episode_thumbnail, content_type: /\Aimage\/.*\Z/

  validates :podcast, presence: true

  default_scope -> { order('created_at DESC') }
end
