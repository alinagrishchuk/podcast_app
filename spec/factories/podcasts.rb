FactoryGirl.define do
  factory  :podcast do
    email                 'person@example.com'
    password              'foobar12'
    password_confirmation 'foobar12'
    title                 'title'
  end
end