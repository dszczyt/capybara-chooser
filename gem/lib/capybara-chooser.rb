require 'capybara-chooser/version'
require 'rspec/core'

module Capybara
  module Chooser
    def chooser(value, from: nil, xpath: nil, search: false)
      fail "Must pass a hash containing 'from' or 'xpath'" unless from.present? || xpath.present?

      chooser_container = first(:xpath, xpath) if xpath.present?
      chooser_container ||= first('label', text: from).find(:xpath, '..').find '.chooser-container'

      chooser_container.find('.chooser-field').click

      if search
        chooser_search = 'input.chooser-search'
        find(:xpath, '//body').find(chooser_search).set value
        page.execute_script(%|$("#{chooser_search}:visible").keyup();|)
      end

      drop_container = '.chooser-search-results'
      find(:xpath, '//body').find("#{drop_container} li", text: value).click

      fail unless page.has_no_css? '#chooser-drop-mask'
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::Chooser
end
