class AddThumbnailToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :thumbnail, :string
  end
end
