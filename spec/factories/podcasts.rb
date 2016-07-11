FactoryGirl.define do
  factory  :podcast do
    email                 'person@example.com'
    password              'foobar12'
    password_confirmation 'foobar12'
    title                 'title'
    description           'description of podcast'
    itunes                'http://localhost/'
    stitcher              'http://localhost/'
    podbay                'http://localhost/'
  end
end