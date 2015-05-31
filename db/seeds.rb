
# create guests
guests = 10.times.map do |n|
  User.create(
    email: "some#{n}@email.com",
    name: "name_#{n}",
  )   
end

# create events and host
host = User.first
open_event =   Event.create(what: "Architecture In Helsinki",
                            when:  3.weeks.from_now,
                            where: "Enmore Theatre",
                            user_id: host.id,
                            deadline: 2.weeks.from_now,
                            price: 46)
closed_event = Event.create(what: "West Coast Eagles",
                            when:  3.weeks.from_now,
                            where: "Subiaco Oval",
                            user_id: host.id,
                            deadline: 1.day.ago,
                            price: 90,
                            booked: true)

# create invites for events
open_event.invites.create(user_id: host.id, rsvp: 'going')
closed_event.invites.create(user_id: host.id, rsvp: 'going')
guests.map do |guest|
  open_event.invites.create(user_id: guest.id, rsvp: 'going')
  closed_event.invites.create(user_id: guest.id, rsvp: 'going')  
end
