class Podcast < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :thumbnail, styles: { large: "1000x1000#", medium: "550x550#" },
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
end
