module Query
  module Plan
    module Invites
      extend self

      def all(plan)
        Invite.where(plan: plan)
      end

      def sorted(plan)
        sorted = []
        sorted << grouped(plan)["going"]
        sorted << grouped(plan)["maybe"]
        sorted << grouped(plan)["not-going"]
        sorted << grouped(plan)["undecided"]
        sorted.flatten.compact
      end

      def grouped(plan)
        all(plan).group_by { |i| i.rsvp }
      end
    end
  end
end
