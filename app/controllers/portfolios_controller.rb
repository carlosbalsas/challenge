# frozen_string_literal: true

class PortfoliosController < ApplicationController

  #CoinbaseExchange.initialize('ae92754cc8f24c051ef1144a7c11556d', '4toK/+kC1BTp0iFCBie25YIHli0Wlq42H+cuCsMPgpOCSGEv2E7QdwL94nyg74l+izJB+P236J+9eTOyh6/jYw==', 'password')
  
  #API SECRET 4toK/+kC1BTp0iFCBie25YIHli0Wlq42H+cuCsMPgpOCSGEv2E7QdwL94nyg74l+izJB+P236J+9eTOyh6/jYw==
  #API ae92754cc8f24c051ef1144a7c11556d

  #KRAKEN PUBLIC 2+jKsNd6v3Z4R2wA6zK7o0GlkuHPJWQ5yBE5GxIFPtoZzIU4UQrYudh7
  #KRAKEN KUC+0fAkn47uFR9ownq1D/XNgc23hHSvt/qEtRmcqz+eb5jj81SnDAJ+mCAga8DxvH7b4sl2yZKZYkFFURsyquYr

  #https://futures.kraken.com/derivatives/api/v3
  def index 
    @orders = Order.where(updated_at: 24.hours.ago..Time.now).order(created_at: :asc)
    #url = "https://api-public.sandbox.pro.coinbase.com/time"
    #body = RestClient.get(url)
    #json = JSON.parse(body)

    

    #TODO Show the currencies the user owns via APIs 


  end

  def buy
    params.require([:coin, :amount, :limit])
    coin = params[:coin]
    amount = params[:amount]
    limit = params[:limit]
    #@currencies = Currency.all

    task = Concurrent::TimerTask.new(execution_interval: 2, timeout_interval: 2){
      url_coinbase = "https://api-public.sandbox.pro.coinbase.com/products/#{coin}-EUR/ticker"
      body_coinbase = RestClient.get(url_coinbase)
      json_coinbase = JSON.parse(body_coinbase)
      price_coinbase = json_coinbase['price']
      puts price_coinbase

      #url_binance = "https://api-public.sandbox.pro.coinbase.com/products/#{coin}/ticker"
      #body_binance = RestClient.get(url)
      #json_binance = JSON.parse(body)
      #price_binance = json_binance['price']
      #puts price_binance
      
      if price_coinbase <= limit or price_binance <= limit
        if price_coinbase <= price_binance
          response_coinbase = RestClient.post("https://api-public.sandbox.pro.coinbase.com/orders?side=buy&type=market&product_id=#{coin}-EUR&funds=amount")
          pjson_coinbase = JSON.parse(response_coinbase)
          fee_coinbase = pjson_coinbase['fill_fees']

          order_coinbase = Order.create(amount: amount, coin: coin.to_s, price: pjson_coinbase['price'], fee: fee_coinbase, broker: 'coinbase', status: 'completed')
          order_coinbase.save!

          order_binance = Order.create(amount: amount, coin: coin.to_s, price: pjson_binance['price'], fee: fee_binance, broker: 'binance', status: 'rejected')
          order_binance.save!
    
          task.shutdown
        else 
          response_binance = RestClient.post("https://api-public.sandbox.pro.coinbase.com/orders?side=buy&type=market&product_id=#{coin}-EUR&funds=amount")
          pjson_binance = JSON.parse(response_binance)
          fee_binance = pjson_binance['fill_fees']

          order_binance = Order.create(amount: amount, coin: coin.to_s, price: pjson_binance['price'], fee: fee_binance, broker: 'binance', status: 'completed')
          order_binance.save!

          order_coinbase = Order.create(amount: amount, coin: coin.to_s, price: pjson_coinbase['price'], fee: fee_coinbase, broker: 'coinbase', status: 'rejected')
          order_coinbase.save!

          task.shutdown
        end
      end
    }
    task.execute
  end
  
end

require 'base64'
require 'openssl'
require 'json'

class CoinbaseExchange
    def initialize(key, secret, passphrase)
      @key = key
      @secret = secret
      @passphrase = passphrase
    end

    def signature(request_path='', body='', timestamp=nil, method='GET')
      body = body.to_json if body.is_a?(Hash)
      timestamp = Time.now.to_i if !timestamp

      what = "#{timestamp}#{method}#{request_path}#{body}";

      # create a sha256 hmac with the secret
      secret = Base64.decode64(@secret)
      hash  = OpenSSL::HMAC.digest('sha256', secret, what)
      Base64.strict_encode64(hash)
      
    end
end
