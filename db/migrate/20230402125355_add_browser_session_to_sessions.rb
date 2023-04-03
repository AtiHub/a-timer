class AddBrowserSessionToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column(:sessions, :browser_session, :string)
  end
end
