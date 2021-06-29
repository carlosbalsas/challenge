# frozen_string_literal: true

class AddBrokerToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :broker, :string
  end
end
