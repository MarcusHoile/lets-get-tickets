module Policy
  module Content
    module Invite
      extend self

      def prompt?(user, event)
        event.host?(user) && event.no_invites?
      end
    end
  end
end
