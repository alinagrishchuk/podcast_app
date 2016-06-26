module SearchablePodcast
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping dynamic: 'false' do
      indexes :title
      indexes :description

      indexes :episodes, :type => "nested" do
        indexes :title
        indexes :description
        indexes :tags, :type => "nested" do
          indexes :name
        end
      end
    end

    def as_indexed_json(options={})
      podcast_attrs = {
        :title => self.title,
        :description => self.description
      }

      podcast_attrs[:episodes] = self.episodes.map do |e|
        {
          :title => e.title,
          :description => e.description,
          :tags => e.tags.map{ |t| {name: t.name} }
        }
      end

      podcast_attrs.as_json
    end
  end
end
