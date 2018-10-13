# This migration comes from refinery_inquiries (originally 1)
class CreateInquiries < ActiveRecord::Migration[5.1]

  def up
    create_table :refinery_inquiries do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :additional_comments

     t.timestamps
    end

    add_index :refinery_inquiries, :id
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "inquiries"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/inquiries"})
    end

    drop_table :refinery_inquiries
  end

end
