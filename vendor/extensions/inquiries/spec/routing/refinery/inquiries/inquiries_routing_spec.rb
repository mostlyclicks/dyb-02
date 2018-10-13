require "spec_helper"

describe "Inquiries front-end routing", type: :routing do

  routes { Refinery::Core::Engine.routes }

  it "can route to index" do
    expect( :get => "/inquiries" ).to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "index",
      :locale => :en
    )
  end

  it "can route to new" do
    expect( :get => "/inquiries/new" ).to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "new",
      :locale => :en
    )
  end

  it "can route to create" do
    expect( :post => "/inquiries" ).to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "create",
      :locale => :en
    )
  end

  it "routes to thank_you" do
    expect( :get => "/inquiries/thank_you" ).to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "thank_you",
      :locale => :en
    )
  end

  it "does not route to show" do
    expect( :get => "/inquiries/1" ).not_to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "show",
      :locale => :en
    )
  end

  it "does not route to edit" do
    expect( :get => "/inquiries/1/edit" ).not_to route_to(
      :controller => "refinery/inquiries/inquiries",
      :action => "edit",
      :locale => :en
    )
  end

  it "does not route to update" do
    expect( :update => "/inquiries/1" ).not_to be_routable
  end

  it "does not route to delete" do
    expect( :delete => "/inquiries/1" ).not_to be_routable
  end

end
