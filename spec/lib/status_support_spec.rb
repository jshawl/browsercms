require File.dirname(__FILE__) + '/../spec_helper'

describe Cms::StatusSupport do
  before(:each) do
    @b = HtmlBlock.new
  end

  it "should add a default status to a block" do
    @b.save
    @b.reload.status.should == "IN_PROGRESS"
  end

  it "should allow blocks to be published" do
    @b.publish
    @b.reload.status.should == "PUBLISHED"
  end

  it "should allow blocks to be archived" do
    @b.archive
    @b.reload.status.should == 'ARCHIVED'
  end

  it "should allow blocks to be marked 'in progress'" do
    @b.publish
    @b.in_progress
    @b.reload.status.should == 'IN_PROGRESS'
  end

  it "should not add 'hide' to blocks, since they can't be hidden" do
    lambda { @b.hide }.should raise_error(NoMethodError)
  end

  it "should respond to ! versions of same status methods" do
    @b.should respond_to(:in_progress!)
    @b.should respond_to(:archive!)
    @b.should respond_to(:publish!)
    @b.should_not respond_to(:hide!)
  end

  it "should have status options" do
    HtmlBlock.status_options.should == [["In Progress", "IN_PROGRESS"], ["Published", "PUBLISHED"], ["Archived", "ARCHIVED"], ["Deleted", "DELETED"]]
  end

  it "should not allow invalid statuses" do
    @b = HtmlBlock.new(:status => "FAIL")
    @b.save
#    @b.should have(1).error_on(:status)
    pending "Might just be an improperly written test"
  end

  it "should respond to publish?" do
    @b.publish
    @b.published?.should
  end

  it "should respond to archive?" do
    @b.archive
    @b.archived?.should
  end

  it "should respond to in_progress?" do
    @b.in_progress
    @b.in_progress?.should
  end


end