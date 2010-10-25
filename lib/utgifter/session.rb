require 'rubygems'
require 'mechanize'

module Utgifter
  BASE_URL = 'http://utgifter.no'

  class Session
    def initialize
      @agent = Mechanize.new
    end

    def login(email, password)
      page = @agent.get(BASE_URL)

      return false if logged_in_to_page?(page)

      form = page.form_with(:action => '/')
      form['username'] = email
      form['password'] = password

      page = form.submit(form.buttons[0])
      logged_in_to_page?(page)
    end

    def logged_in?
      page = @agent.get(BASE_URL)
      logged_in_to_page?(page)
    end

    def logout
      page = @agent.get(BASE_URL)

      return false unless logged_in_to_page?(page)

      page = logout_link(page).click
      !logged_in_to_page?(page)
    end

    private

    def logged_in_to_page?(page)
      !logout_link(page).nil?
    end

    def logout_link(page)
      page.link_with(:href => '/logout/')
    end
  end
end
