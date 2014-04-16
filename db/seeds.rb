# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
# guest1 = User.create(name: "Rachel O'Toole", email: "marcushoile1@gmail.com")
# guest2 = User.create(name: "Kate Saint George", email: "marcushoile2@gmail.com")
# guest3 = User.create(name: "Tom Arnold", email: "marcushoile3@gmail.com")
# guest4 = User.create(name: "Sam Olle", email: "marcushoile4@gmail.com")

# event1 = Event.create(what: "Architecture In Helsinki", where: "Enmore Theatre", user_id: 1)

wdi3_emails = %w(alberto.forn@gmail.com fede.tagliabue@gmail.com marcus.hoile@gmail.com lukru489@gmail.com peters.sammyjo@gmail.com emacca@me.com stalin.pranava@gmail.com eduard.fastovski@gmail.com ltfschoen@gmail.com cptnmrgn10@gmail.com lukemesiti@gmail.com)

wdi3_emails.each do |email|
  first_part = email[/[^@]+/]
  first_part = first_part.split('').map do |letter|
    if letter.match(/\A[\w]+\z/)
      letter
    else
      ''
    end
  end.join('')

  User.create(
    email: email,
    name: first_part,
    password: 'changeme',
    password_confirmation: 'changeme'
  )
end