class RemoveAttachmentThumbnailFromPodcasts < ActiveRecord::Migration
  def self.up
    remove_attachment :podcasts, :thumbnail
  end

  def self.down
    change_table :podcasts do |t|
      t.attachment :thumbnail
    end
  end

end
