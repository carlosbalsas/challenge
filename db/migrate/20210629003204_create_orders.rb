# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :currency
      t.integer :amount

      t.timestamps
    end
  end
end
