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
  end
end