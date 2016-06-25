images = Dir.glob("#{Rails.root}/db/seeds/img/*.jpg")
mp3s = Dir.glob("#{Rails.root}/db/seeds/mp3/*.mp3")

#for all  podcasts
8.times do |i|
  email =  Faker::Internet.user_name + i.to_s +
    "@#{Faker::Internet.domain_name}"

  podcast = Podcast.create!({ email:                  email,
                              password:               'foobar12',
                              password_confirmation:  'foobar12',
                              title:                  Faker::Hipster.sentence,
                              description:            Faker::Hipster.paragraph(3),
                              itunes:                 'https://www.apple.com/ru/itunes/',
                              podbay:                 'https://podbay.fm/',
                              thumbnail:              File.open(images.sample) })

  10.times do
    podcast.episodes.create!({  title:                  Faker::Hipster.sentence,
                                description:            Faker::Hipster.paragraph(2),
                                episode_thumbnail:      File.open(images.sample),
                                mp3:                    File.open(mp3s.sample) })
  end
end


#for main  podcast
main_podcast = Podcast.create!({ email:                  'test@example.com',
                                 password:               'test@example.com',
                                 password_confirmation:  'test@example.com',
                                 title:                  Faker::Hipster.sentence,
                                 description:            Faker::Hipster.paragraph(3),
                                 itunes:                 'https://www.apple.com/ru/itunes/',
                                 podbay:                 'https://podbay.fm/',
                                 thumbnail:              File.open(images.sample) })
15.times do
  main_podcast.episodes.create!({ title:                  Faker::Hipster.sentence,
                                  description:            Faker::Hipster.paragraph(2),
                                  episode_thumbnail:      File.open(images.sample),
                                  mp3:                    File.open(mp3s.sample) })
end


tags = %w( chillout electronic ambient
           downtempo indie lounge chillwave house summer
           experimental dark instrumental drone
           psytrance chill chillwave)
Episode.all.each { |e| e.all_tags = tags.sample(3).join(','); e.save! }