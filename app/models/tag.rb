class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :episodes, through: :taggings


  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.usage
    joins(:episodes).
    group('tags.name').
    select('tags.name , count(episodes.id) as count').
    order('count desc')
  end

end
