class RecordsController < ApplicationController
  include ActionView::RecordIdentifier

  def show
    @record = Record.find(params[:id])
    @index = @record.session.records.order(created_at: :asc).pluck(:id).index(@record.id) + 1
  end

  def new
    @session = Session.find(params[:session_id]) if params[:session_id].present?
    @record = Record.new
  end

  def create
    @record = Record.create!(record_params)
    @times = @record.session.records.order(created_at: :desc).limit(12).map(&:time)

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.prepend('records-table', partial: 'records/record',
          locals: { record: @record, times: @times }))
      end
      # format.html { redirect_to(new_record_path(session_id: record_params[:session_id])) }
    end
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy!

    redirect_to(sessions_path(selected_session_id: record.session_id))
  end

  private

  def record_params
    params.require(:record).permit(:session_id, :time, :scramble)
  end
end
