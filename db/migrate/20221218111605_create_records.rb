class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records, id: :uuid do |t|
      t.uuid(:session_id)
      t.integer(:time)
      t.string(:scramble)

      t.timestamps
    end
  end
end
