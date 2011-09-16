# Everything listed in this migration will be added to a migration file
# inside of your main app.
class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :from_address, :null => false

      t.string :reply_to_address,
               :subject

      t.text   :to_address,
               :cc_address,
               :bcc_address,
               :content

      t.datetime :sent_at
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
