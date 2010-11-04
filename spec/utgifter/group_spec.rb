require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Utgifter::Group do
  before(:each) do
    @session = mock('session', :agent => @agent = mock('agent'))
  end

  it 'should retrieve all groups' do
    group_dropdown = mock('group_dropdown')
    group_dropdown.should_receive(:options).and_return([
      mock('group', :value => 17, :text => 'group a'),
      mock('group', :value => 19, :text => 'group b')
    ])

    form = mock('form')
    form.should_receive(:field_with)
	.with(:name => '__GroupSelector_ChangeGroup')
	.and_return(group_dropdown)

    page = mock('page')
    page.should_receive(:form_with)
      .with(:action => '/expenses/change_group/')
      .and_return(form)

    @agent.should_receive(:get).with(Utgifter::GROUPS_URL)
      .and_return(page)

    Utgifter::Group.all(@session).should == [
      Utgifter::Group.new(@session, 17, 'group a'),
      Utgifter::Group.new(@session, 19, 'group b')
    ]
  end
end
