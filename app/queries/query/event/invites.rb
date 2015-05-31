module Query
  module Event
    module Invites
      extend self

      def all(event)
        Invite.where(event: event)
      end

      def sorted(event)
        sorted = []
        sorted << grouped(event)["going"]
        sorted << grouped(event)["maybe"]
        sorted << grouped(event)["not-going"]
        sorted << grouped(event)["undecided"]
        sorted.flatten.compact
      end

      def grouped(event)
        all(event).group_by { |i| i.rsvp }
      end
    end
  end
end
