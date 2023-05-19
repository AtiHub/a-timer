class SessionsController < ApplicationController
  before_action :set_browser_session
  before_action :set_sessions, only: [:index]
  before_action :set_selected_session, only: [:index]

  def index
    @records = @selected_session.records.order(created_at: :asc)
    @times = @records.map(&:time).reverse
  end

  def show
    @session = Session.find(params[:id])
    @records = @session.records
  end

  def create
    @session = Session.create!(browser_session: @browser_session)

    redirect_to(sessions_path(selected_session_id: @session.id))
  end

  def destroy
    session = Session.find(params[:id])
    session.destroy!

    redirect_to(sessions_path)
  end

  private

  def set_sessions
    @sessions ||= Session.where(browser_session: @browser_session).order(created_at: :asc)
  end

  def set_selected_session
    @selected_session ||= if params[:selected_session_id].present?
      @sessions.find(params[:selected_session_id])
    else
      @sessions.first
    end

    @selected_session ||= Session.create!(browser_session: @browser_session)
  end

  def set_browser_session
    @browser_session = cookies[:browser_session]
  end
end
