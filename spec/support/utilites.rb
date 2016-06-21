def valid_signin(podcast)
  fill_in 'Email',    with: podcast.email
  fill_in 'Password', with: podcast.password
  click_button 'Log in'
end

def sign_in(podcast)
  visit new_podcast_session_path
  valid_signin(podcast)
end