module Query
  module User
    module Plans
      extend self

      def all(user)
        ::Plan.joins(:invites).where(host: user).where('invites.user_id' => user).order(deadline: :desc)
      end
    end
  end
end
