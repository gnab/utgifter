module Utgifter
  BASE_URL = 'http://utgifter.no'
  GROUP_URL = BASE_URL + '/user/group/list/'

  autoload :Session, 'utgifter/session'
  autoload :Group, 'utgifter/group'
end
