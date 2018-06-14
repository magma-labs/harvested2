require 'httparty'
require 'base64'
require 'delegate'
require 'hashie'
require 'json'
require 'time'
require 'csv'

require 'ext/array'
require 'ext/hash'
require 'ext/date'
require 'ext/time'

require 'harvest/version'
require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/hardy_client'
require 'harvest/timezones'

require 'harvest/base'

%w(crud activatable).each { |a| require "harvest/behavior/#{a}" }

%w(model client contact project task user task_assignment
user_assignment estimate expense_category expense time_entry invoice_category
line_item invoice invoice_payment
invoice_message).each { |a| require "harvest/#{a}" }

%w(base account clients contacts projects tasks users task_assignments
user_assignments estimates expense_categories expenses time_entry
invoice_categories invoices invoice_payments
invoice_messages).each { |a| require "harvest/api/#{a}" }

module Harvest
  class << self

    # Creates a standard client that will raise all errors it encounters
    #
    # == Options
    # * Basic Authentication V2
    #   * +:access_token+ - Your Harvest access_token
    #   * +:account_id+ - Your Harvest account_id
    #   * +:client_id+ - An OAuth 2.0 access token
    #
    # == Examples
    #   Harvest.client(access_token: 'token', account_id: '123')
    #   Harvest.client(access_token: 'myaccesstoken', client_id: '1')
    #
    # @return [Harvest::Base]
    def client(access_token: nil, account_id: nil, client_id: nil)
      Harvest::Base.new(access_token: access_token, account_id: account_id,
        client_id: client_id)
    end

    # Creates a hardy client that will retry common HTTP errors
    # it encounters and sleep() if it determines it is over your rate limit
    #
    # == Options
    # * Basic Authentication
    #   * +:access_token+ - Your Harvest access_token
    #   * +:account_id+ - Your Harvest account_id
    #   * +:client_id+ - An OAuth 2.0 access token
    #   * +:retry+ - How many times the hardy client should retry errors.
    #              Set to +5+ by default.
    #
    # == Examples
    #   Harvest.hardy_client(access_token: 'token', account_id: '123', retry: 3)
    #
    #   Harvest.hardy_client(access_token: 'myaccesstoken', client_id: '1',
    #                        retries: 3)
    #
    # == Errors
    # The hardy client will retry the following errors
    # * Harvest::Unavailable
    # * Harvest::InformHarvest
    # * Net::HTTPError
    # * Net::HTTPFatalError
    # * Errno::ECONNRESET
    #
    # == Rate Limits
    # The hardy client will make as many requests as it can until it detects it
    # has gone over the rate limit. Then it will +sleep()+ for the how ever
    # long it takes for the limit to reset. You can find more information about
    # the Rate Limiting at http://www.getharvest.com/api
    #
    # @return [Harvest::HardyClient] a Harvest::Base wrapped in a Harvest::HardyClient
    # @see Harvest::Base
    def hardy_client(access_token: nil, account_id: nil, client_id: nil, retries: 5)
      Harvest::HardyClient.new(client(
        access_token: access_token,
        account_id: account_id,
        client_id: client_id),
        retries)
    end
  end
end
