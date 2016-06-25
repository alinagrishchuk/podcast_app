## Result
https://podcast-application.herokuapp.com/

## User Stories

- As a user, I want to be able to explore / discover new podcasts so that I can find new stuff to listen to
- As a user, I want to be able to sign up & create a podcast, so that my audience can listen to my podcast episodes.
- As a user, I want to be able to listen to podcast mp3
- As an authorized user, I want to be able sign in & out so that I can access my account
- As an  authorized user, I want to be able to add podcast episodes so that my audience can listen it
- As an  authorized user, I want to be able to edit or delete podcast episodes so that I can manage my podcast
- As an authorized user, I want to be able to add images to my podcast episodes
- As an authorized user, I want to be able to upload MP3s


## Features

- Users, sign up / in / out
- Authentication so that a user can only access their own content
- CRUD for podcast episodes
- Image uploading 
- MP3 uploading
- store assets on Cloudinary & Dropbox
- Launch application live on Heroku


## Data 

**Podcast**
has_many :episodes
 - email 
 - password
 - description
 - title
 - thumbnail
 - episode
 - itunes link
 - stitcher link
 - podbay link
 
**Episode**
 - description
 - title
 - podcast id
 - thumbnail
 - mp3
 
 **Tag**
  - name
  
 **Taggings**
  - episode_id
  - tag_id

## Pages 

 - Welcome Page (welcome#index)
 - Sign In (session#new)
 - Sign Out (session#destroy)
 - Podcasts (podcasts#index)
 - Podcast Single (podcasts#show)
 - Podcast Edit (podcasts#edit)
 - Episode Page (episode#show)
 - Episode New (episode#new)
 - Episode Edit (episode#edit)
 - Dashboard (podcast#dashboard)  
  
  
 