FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:title) { |n| "podcast#{n}" }

  factory  :podcast do
    email
    password              'foobar12'
    password_confirmation 'foobar12'
    title
    description           'description of podcast'
    itunes                'https://www.apple.com/ru/itunes/'
    stitcher              'https://www.stitcher.com/'
    podbay                'https://podbay.fm/'

    factory :podcast_with_episodes_and_tags do
      transient do
        episodes_count 1
        all_tags ''
      end

      after(:create) do |podcast, evaluator|
        create_list(:episode, evaluator.episodes_count, all_tags: evaluator.all_tags, podcast: podcast)
      end
    end

  end
end