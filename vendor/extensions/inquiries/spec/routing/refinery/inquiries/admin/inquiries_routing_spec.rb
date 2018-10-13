require "spec_helper"

describe "inquiries admin routing", type: :routing do

  routes { Refinery::Core::Engine.routes }

  it "can route to new" do
    expect( :get => "/refinery/inquiries/new" ).to route_to(
      :controller => "refinery/inquiries/admin/inquiries",
      :action => "new",
      :locale => :en
    )

  end

  it "can route to create" do
    expect( :post => "/refinery/inquiries" ).to be_routable
  end

  it "can route to show" do
    expect( :get => "/refinery/inquiries/1" ).to route_to(
      :controller => "refinery/inquiries/admin/inquiries",
      :action => "show",
      :id => '1',
      :locale => :en
    )
  end

  it "can route to edit" do
    expect( :get => "/refinery/inquiries/1/edit" ).to route_to(
      :controller => "refinery/inquiries/admin/inquiries",
      :action => "edit",
      :id => "1",
      :locale => :en
    )
  end

  it "does not route to update" do
    expect( :update => "/refinery/inquiries/1" ).not_to be_routable
  end

  it "does route to delete" do
    expect( :delete => "/refinery/inquiries/1" ).to route_to(
      :controller => "refinery/inquiries/admin/inquiries",
      :action => "destroy",
      :id => '1',
      :locale => :en
    )
  end

end
