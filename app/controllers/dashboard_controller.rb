class DashboardController < ApplicationController
  before_action :set_browser_session

  def main
    @sessions = Session.all
  end

  private

  def set_browser_session
    if cookies[:browser_session]
      @browser_session = cookies[:browser_session]
    else
      loop do
        token = SecureRandom.hex(16)
        next if Session.exists?(browser_session: token)

        (@browser_session = token) && break
      end

      cookies[:browser_session] = @browser_session
    end
  end
end
