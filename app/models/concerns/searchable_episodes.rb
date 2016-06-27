module SearchableEpisodes
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :title, index_options: 'offsets'
        indexes :description
      end
    end

    def self.seacrh_with_or_statement term
      search(query: { match:
                        { _all: { query: term,
                                  operator: 'or'} } })
    end

    # The best_fields type is most useful when you
    # are searching for multiple words best found in the same field.
    def self.seacrh_with_best_fields term
      search(query: { multi_match: { query: term,
                                     fields: ["title^4",
                                              "description"] } })
    end

    # The most_fields type is most useful when querying multiple fields
    # that contain the same text analyzed in different ways
    def self.seacrh_with_most_fields term
      search(query: { multi_match: { query: term,
                                     fields: ["title^4",
                                              "description"] } })
    end


    def self.seacrh_with_highlight term
      search( query: { multi_match: {  query: term,
                                       fields: ['title^4' ,
                                                "description"] } },
              highlight: { fields: { title:       {},
                                     description: {} }
              })
    end
  end
end

