module Query
  module Event
    module Demo
      extend self

      def all
        ::Event.where(demo: true)
      end

      def open
        all.where(status: 'open').first
      end

      def closed
        all.where(status: 'closed').first
      end
    end
  end
end
