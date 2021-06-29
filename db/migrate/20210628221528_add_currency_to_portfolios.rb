# frozen_string_literal: true

class AddCurrencyToPortfolios < ActiveRecord::Migration[6.1]
  def change
    add_reference :portfolios, :currency, null: false, foreign_key: true
  end
end
