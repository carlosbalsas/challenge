# frozen_string_literal: true

class AddCurrenciesToPortfolio < ActiveRecord::Migration[6.1]
  def change
    add_reference :currencies, :portfolio
  end
end
