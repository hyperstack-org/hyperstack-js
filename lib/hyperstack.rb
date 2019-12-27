# frozen_string_literal: true

require 'active_support'
require 'time'
require 'date'
require 'opal-jquery'
require 'browser'
require 'browser/interval'
require 'browser/delay'

require 'hyperstack-config'

module Hyperstack
  def self.env
    @environment ||= ActiveSupport::StringInquirer.new('express')
  end
end

require 'hyperstack/autoloader'
require 'hyperstack/autoloader_starter'
require 'hyper-component'
require 'hyperstack/component/auto-import'
require 'hyper-state'
require 'hyper-operation'
