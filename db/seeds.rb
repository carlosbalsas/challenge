# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Order.create!(amount: 1, coin: 'BTC', price: 100000, fee: 12000, broker: 'coinbase', status: 'completed').save
Order.create!(amount: 1, coin: 'BTC', price: 100000, fee: 13000, broker: 'binance', status: 'rejected').save
Order.create!(amount: 1, coin: 'BTC', price: 104000, fee: 12000, broker: 'coinbase', status: 'completed').save
Order.create!(amount: 1, coin: 'BTC', price: 105000, fee: 12000, broker: 'binance', status: 'rejected').save
Order.create!(amount: 1, coin: 'BTC', price: 120000, fee: 21000, broker: 'binance', status: 'completed').save
Order.create!(amount: 1, coin: 'BTC', price: 136000, fee: 12300, broker: 'coinbase', status: 'rejected').save
