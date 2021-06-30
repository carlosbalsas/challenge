# frozen_string_literal: true

class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.string :currency

      t.timestamps
    end
  end
end
