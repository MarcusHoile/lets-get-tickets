module Query
  module Plan
    module Demo
      extend self

      def all
        ::Plan.where(demo: true)
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
