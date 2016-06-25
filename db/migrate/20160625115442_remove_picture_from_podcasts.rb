class RemovePictureFromPodcasts < ActiveRecord::Migration
  def change
    remove_column :podcasts, :picture, :string
  end
end
