class DashboardController < ApplicationController
  def main
    @sessions = Session.all
  end
end
