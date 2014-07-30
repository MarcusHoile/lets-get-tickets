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


wdi3_emails = %w(marcus.hoile@gmail.com fede.tagliabue@gmail.com lukru489@gmail.com peters.sammyjo@gmail.com emacca@me.com stalin.pranava@gmail.com eduard.fastovski@gmail.com ltfschoen@gmail.com cptnmrgn10@gmail.com lukemesiti@gmail.com)

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
event1 = Event.create(what: "Architecture In Helsinki", event_when:  "Mon, 31 Jul 2014 21:46:06", where: "Enmore Theatre", user_id: 1, on_sale:  "Mon, 27 Jul 2014 20:46:06", price: 46)


User.where("id > ?", 1).each do |u|
  event1.invites.create(user_id: u.id, rsvp: "Going");
end