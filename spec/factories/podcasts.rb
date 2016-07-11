FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }

  factory  :podcast do
    email
    password              'foobar12'
    password_confirmation 'foobar12'
    title                 'title'
    description           'description of podcast'
    itunes                'http://localhost/'
    stitcher              'http://localhost/'
    podbay                'http://localhost/'

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