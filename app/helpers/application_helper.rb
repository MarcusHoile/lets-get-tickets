module ApplicationHelper
	def shallow_args(parent, child)
		child.try(:new_record?) ? [parent, child] : child
	end

	def get_rsvp_badge(invite)
		if invite.rsvp == 'going'
			@badge = '✓'
		elsif invite.rsvp == 'not-going'
			@badge = 'x'
		elsif invite.rsvp == 'maybe'
			@badge = '?'
		end
	end
end
