class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_attached_file :episode_thumbnail,
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
                    :path => "episodes/:id/:style/:id_:filename"
  validates_attachment_content_type :episode_thumbnail, content_type: /\Aimage\/.*\Z/

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

  default_scope -> { order('created_at DESC') }
end
