class AddColumnPaymentMethodToInvites < ActiveRecord::Migration
  def up
    add_column :invites, :payment_method, :string
  end
end
