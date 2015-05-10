module Policy
  module Content
    module Invite
      extend self

      def prompt?(user, event)
        event.owner?(user) && event.no_invites?
      end
    end
  end
end
