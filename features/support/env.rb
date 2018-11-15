require 'capybara'
require 'capybara/cucumber'
require 'byebug'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require_relative 'helper.rb'
require_relative 'page_helper.rb'

World(Pages)
World(Helper)

AMBIENTE = ENV['AMBIENTE']
BROWSER = ENV['BROWSER']

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{AMBIENTE}.yml")

## register driver according with browser chosen
Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome_headless')
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--window-size=1600,1024',
      '--disable-dev-shm-usage', '--no-sandbox' ])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)

  elsif BROWSER.eql?('chrome')
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--disable-infobars', 'window-size=1600,1024'])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)
  end
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = CONFIG['url_padrao']
  config.default_max_wait_time = 10
end
