# frozen_string_literal: true

class PortfoliosController < ApplicationController

  #CoinbaseExchange.initialize('ae92754cc8f24c051ef1144a7c11556d', '4toK/+kC1BTp0iFCBie25YIHli0Wlq42H+cuCsMPgpOCSGEv2E7QdwL94nyg74l+izJB+P236J+9eTOyh6/jYw==', 'password')
  
  #API SECRET 4toK/+kC1BTp0iFCBie25YIHli0Wlq42H+cuCsMPgpOCSGEv2E7QdwL94nyg74l+izJB+P236J+9eTOyh6/jYw==
  #API ae92754cc8f24c051ef1144a7c11556d

  #KRAKEN PUBLIC 2+jKsNd6v3Z4R2wA6zK7o0GlkuHPJWQ5yBE5GxIFPtoZzIU4UQrYudh7
  #KRAKEN KUC+0fAkn47uFR9ownq1D/XNgc23hHSvt/qEtRmcqz+eb5jj81SnDAJ+mCAga8DxvH7b4sl2yZKZYkFFURsyquYr

  #https://futures.kraken.com/derivatives/api/v3
  def index 
    @currencies = Currency.all
    url = "https://api-public.sandbox.pro.coinbase.com/time"
    body = RestClient.get(url)
    json = JSON.parse(body)
    puts json

    

    #TODO Show the currencies the user owns


  end

  def buy
    params.require([:coin, :amount, :limit])
    coin = params[:coin]
    amount = params[:amount]
    limit = params[:limit]
    #@currencies = Currency.all

    task = Concurrent::TimerTask.new(execution_interval: 2, timeout_interval: 2){
      url = "https://api-public.sandbox.pro.coinbase.com/products/#{coin}/ticker"
      body = RestClient.get(url)
      json = JSON.parse(body)
      price_coinbase = json['price']
      puts price_coinbase
      
      if price_coinbase <= limit
        
        response = RestClient.post("https://api-public.sandbox.pro.coinbase.com/orders?side=buy&type=market&product_id=#{coin}&funds=amount")
        pjson = JSON.parse(response)
        fee = pjson['fill_fees']
        order = Order.create(amount: amount, coin: coin.to_s, price: json['price'], fee: fee, broker: 'coinbase')
        order.save
        task.shutdown
      else 
        if price_binance <= limit
        
        response = RestClient.post("https://api-public.sandbox.pro.coinbase.com/orders?side=buy&type=market&product_id=#{coin}&funds=amount")
        pjson = JSON.parse(response)
        fee = pjson['fill_fees']
        order = Order.create(amount: amount, coin: coin.to_s, price: json['price'], fee: fee, broker: 'binance')
        order.save!
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
      sign = Base64.strict_encode64(hash)
      return sign
      
    end
end
