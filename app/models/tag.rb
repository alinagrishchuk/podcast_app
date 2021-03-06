class Tag < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :taggings
  has_many :episodes, through: :taggings

  scope :with_name, -> (name) { where(name: name) }

  def self.usage
    joins(:episodes).
    group('tags.name').
    select('tags.name , count(episodes.id) as count').
    order('count desc')
  end

end
