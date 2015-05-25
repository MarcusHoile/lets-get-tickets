module Query
  module User
    module Events
      extend self

      def all(user)
        ::Event.joins(:invites).where(host: user).where('invites.user_id' => user).order(deadline: :desc)
      end
    end
  end
end
