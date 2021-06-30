# frozen_string_literal: true

class AddPriceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :price, :integer
  end
end
