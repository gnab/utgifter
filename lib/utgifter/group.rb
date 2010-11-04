require 'rubygems'
require 'mechanize'

module Utgifter
  GROUPS_URL = BASE_URL + '/user/group/list/'

  class Group
    attr_reader :session, :id, :name

    def initialize(session, id, name)
      @session = session
      @id = id
      @name = name
    end

    def self.all(session)
      page = session.agent.get(GROUPS_URL)

      page
	.form_with(:action => '/expenses/change_group/')
	.field_with(:name => '__GroupSelector_ChangeGroup')
	.options
	.collect do |option|
	  Group.new(session, option.value.to_i, option.text.strip)
	end
    end

    def members
      User.all(self)
    end

    def ==(other)
      return false unless other
      id == other.id && name == other.name
    end
  end
end
