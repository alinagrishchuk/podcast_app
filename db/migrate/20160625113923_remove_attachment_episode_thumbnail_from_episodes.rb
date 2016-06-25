class RemoveAttachmentEpisodeThumbnailFromEpisodes < ActiveRecord::Migration
  def self.up
    remove_attachment :episodes, :episode_thumbnail
  end

  def self.down
    change_table :episodes do |t|
      t.attachment :episode_thumbnail
    end
  end
end
