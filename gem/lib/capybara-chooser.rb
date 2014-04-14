require 'capybara-chooser/version'
require 'rspec/core'

module Capybara
  module Chooser
    def chooser(value, from: nil, xpath: nil, search: false)
      fail "Must pass a hash containing 'from' or 'xpath'" unless from.present? || xpath.present?

      chooser_container = first(:xpath, xpath) if xpath.present?
      chooser_container ||= first('label', text: from).find(:xpath, '..').find '.chooser-container'

      chooser_container.find('.chooser-selected').click

      if search
        chooser_search = 'input.chooser-search'
        find(:xpath, '//body').find(chooser_search).set value
        page.execute_script(%|$("#{chooser_search}:visible").keyup();|)
      end

      drop_container = '.chooser-search-results'
      find(:xpath, '//body').find("#{drop_container} li", text: value).click

      fail unless page.has_no_css? '#chooser-drop-mask'
    end

    # def chooser_ajax(value, from: nil, xpath: nil, search: false, parent: '')
    #   fail "Must pass a hash containing 'from' or 'xpath'" unless from.present? || xpath.present?

    #   chooser_container = first(:xpath, xpath) if xpath.present?
    #   chooser_container ||= first('label', text: from).find(:xpath, '..').find '.chooser-container'

    #   chooser_container.find('.chooser-choice').click

    #   if search
    #     chooser_input = "#{parent} input.chooser-input".strip
    #     find(:xpath, '//body').find(chooser_input).set value
    #     page.execute_script(%|$("#{chooser_input}:visible").keyup();|)
    #   end

    #   drop_container = search ? '.chooser-results' : '.chooser-drop'
    #   find(:xpath, '//body').find("#{drop_container} li", text: value).click

    #   fail unless page.has_no_css? '#chooser-drop-mask'
    # end

    def chooser_multiple(values, from: nil, xpath: nil)
      fail "Must pass a hash containing 'from' or 'xpath'" unless from.present? || xpath.present?

      chooser_container = first(:xpath, xpath) if xpath.present?
      chooser_container ||= first('label', text: from).find(:xpath, '..').find '.chooser-container'

      [values].flatten.each do |value|
        chooser_container.find(:xpath, "a[contains(concat(' ',normalize-space(@class),' '),' chooser-choice ')] | ul[contains(concat(' ',normalize-space(@class),' '),' chooser-choices ')]").click
        find(:xpath, '//body').find('.chooser-drop li', text: value).click
      end

      fail unless page.has_no_css? '#chooser-drop-mask'
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::Chooser
end
