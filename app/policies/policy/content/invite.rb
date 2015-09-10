module Policy
  module Content
    module Invite
      extend self

      def prompt?(user, plan)
        plan.host?(user) && plan.no_invites?
      end
    end
  end
end
