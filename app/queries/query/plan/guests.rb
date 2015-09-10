module Query
  module Plan
    module Guests
      extend self

      def all(plan)
        plan.guests
         .extending(Scopes)
      end

      module Scopes
        def confirmed
          joins(:invites).where('invites.rsvp' => 'going').uniq
        end

        def not_going
          joins(:invites).where('invites.rsvp' => 'not-going').uniq
        end

        def undecided
          joins(:invites).where('invites.rsvp' => 'undecided').uniq
        end

        def maybe
          joins(:invites).where('invites.rsvp' => 'maybe').uniq
        end
      end
    end
  end
end
