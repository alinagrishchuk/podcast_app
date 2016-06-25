class AddPictureToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :picture, :string
  end
end
