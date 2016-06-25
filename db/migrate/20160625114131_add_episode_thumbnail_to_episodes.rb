class AddEpisodeThumbnailToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :episode_thumbnail, :string
  end
end
