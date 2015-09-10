module Query
  module Plan
    module Notifications
      extend self

      def all(plan)
        Notification.where(active: true, plan: plan)
          .extending(Scopes)
      end

      module Scopes
        def for(user)
          where(user: user)
        end
      end
    end
  end
end
