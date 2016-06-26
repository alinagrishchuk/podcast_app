require 'elasticsearch/model'

BONSAI_URL = ENV['BONSAI_URL']

Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: BONSAI_URL,
  log: true
)