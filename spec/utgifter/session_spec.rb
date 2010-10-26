require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Utgifter::Session do
  before(:each) do
    @agent = mock('agent', :get => @page = mock('page'))
    Mechanize.stub!(:new).and_return(@agent)
    @session = Utgifter::Session.new
  end

  it 'should be able to log in' do
    submit_button = mock('submit_button')

    buttons = mock('buttons')
    buttons.should_receive('[]').with(0).and_return(submit_button)

    form = mock('form')
    form.should_receive('username=').with('username')
    form.should_receive('password=').with('password')
    form.should_receive(:buttons).and_return(buttons)
    form.should_receive(:submit).with(submit_button)

    @page.should_receive(:form_with).with(:action => '/')
      .and_return(form)
    @session.should_receive('logged_in_to_page?').and_return(false, true)

    @session.login('username', 'password').should == true
  end

  it 'should be logged out when logout link is not present' do
    @page.should_receive(:link_with).with(:href => '/logout/')
      .and_return(nil)
    @session.logged_in?.should == false
  end

  it 'should be logged in when logout link is present' do
    @page.should_receive(:link_with).with(:href => '/logout/')
      .and_return(mock('link'))
    @session.logged_in?.should == true
  end

  it 'should be able to log out' do
    logout_link = mock('logout_link')
    logout_link.should_receive(:click)

    @page.should_receive(:link_with).with(:href => '/logout/')
      .and_return(logout_link)
    @session.should_receive('logged_in_to_page?').and_return(true, false)

    @session.logout.should == true
  end
end
