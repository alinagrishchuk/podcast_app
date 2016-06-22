class Episode < ActiveRecord::Base
  belongs_to :podcast

  validates :podcast, presence: true

  default_scope -> { order('created_at DESC') }
end
