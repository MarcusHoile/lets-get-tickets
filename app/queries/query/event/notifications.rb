module Query
  module Event
    module Notifications
      extend self

      def all(event)
        Notification.where(active: true, event: event)
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
