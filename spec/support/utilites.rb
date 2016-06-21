def valid_signin(podcast)
  fill_in 'Email',      with: podcast.email
  fill_in 'Password',   with: podcast.password
  click_button 'Log in'
end

def sign_in(podcast)
  visit new_podcast_session_path
  valid_signin(podcast)
end

def valid_signup(podcast)
  fill_in 'Email',      with: podcast.email
  fill_in 'Password',   with: podcast.password
  fill_in 'Title',      with: podcast.title
  click_button 'Sign up'
end

def sign_up(podcast)
  visit  new_podcast_registration_path
  valid_signup(podcast)
end

def valid_podcast_edit(podcast)
  fill_in "Title",    with: podcast.title
  fill_in "Description",    with: podcast.description
  fill_in "Itunes",    with: podcast.itunes
  fill_in "Stitcher",    with: podcast.stitcher
  fill_in "Podbay",    with: podcast.podbay
  fill_in 'Email',    with: podcast.email
  fill_in 'podcast_current_password', with: podcast.password
  click_button 'Update'
end
