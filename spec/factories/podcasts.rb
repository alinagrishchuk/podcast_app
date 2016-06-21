FactoryGirl.define do
  factory  :podcast do
    email     "person@example.com"
    password  'foobar12'
    password_confirmation 'foobar12'
  end
end