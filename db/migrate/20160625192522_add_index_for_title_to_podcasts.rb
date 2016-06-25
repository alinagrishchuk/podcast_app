class AddIndexForTitleToPodcasts < ActiveRecord::Migration
  def change
    add_index :podcasts, :title
  end
end
