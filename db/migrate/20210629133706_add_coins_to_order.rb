# frozen_string_literal: true

class AddCoinsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coin, :string
  end
end
