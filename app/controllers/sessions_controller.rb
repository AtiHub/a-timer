class SessionsController < ApplicationController
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

  def new

  end

  def destroy

  end

  private

  def set_sessions
    @sessions ||= Session.all.order(created_at: :asc)
  end

  def set_selected_session
    @selected_session ||= if params[:selected_session_id].present?
      @sessions.find(params[:selected_session_id])
    else
      @sessions.first
    end
  end
end
