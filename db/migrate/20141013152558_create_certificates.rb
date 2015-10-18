class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :last_name
      t.string :first_name
      t.string :city
      t.string :credential
      t.date :earned
      t.integer :status

      t.timestamps
    end
  end
end
