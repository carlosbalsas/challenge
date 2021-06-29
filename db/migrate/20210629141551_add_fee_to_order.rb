# frozen_string_literal: true

class AddFeeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :fee, :integer
  end
end
