require 'rubygems'
require 'mechanize'

module Utgifter
  class Group
    attr_reader :id, :name

    def initialize(session, id, name)
      @session = session
      @id = id
      @name = name
    end

    def self.all(session)
      page = session.agent.get(GROUP_URL)

      group_dropdown = page
	.form_with(:action => '/expenses/change_group/')
	.field_with(:name => '__GroupSelector_ChangeGroup')
	.options.collect { |option|
	  Group.new(session, option.value.to_i, option.text.strip)
	}
    end

    def ==(other)
      return false unless other
      id == other.id && name == other.name
    end
  end
end
