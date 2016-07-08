module SearchablePodcast
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def as_indexed_json(options={})
     { title: title }
    end

  end
end
