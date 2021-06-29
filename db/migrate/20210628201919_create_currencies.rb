# frozen_string_literal: true

class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :amount

      t.timestamps
    end
  end
end
