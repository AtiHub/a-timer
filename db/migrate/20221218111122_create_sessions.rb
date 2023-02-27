class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.integer(:category, default: 0)

      t.timestamps
    end
  end
end
