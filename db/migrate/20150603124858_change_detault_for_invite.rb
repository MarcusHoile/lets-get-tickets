class ChangeDetaultForInvite < ActiveRecord::Migration
  def change
    change_column_default :invites, :rsvp, 'undecided'
  end
end
