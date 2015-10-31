module Service
  module Plan
    module Invite
      module Create
        extend self

        def call(invite, plan, user, rsvp)
          if invite.validate(guest: user, rsvp: rsvp, plan: plan)
            invite.save(validate: false)
            Hopscotch::Step.success!
          else
            Hopscotch::Step.failure!
          end
        end
      end
    end
  end
end
