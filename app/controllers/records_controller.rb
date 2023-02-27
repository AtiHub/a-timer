class RecordsController < ApplicationController
  include ActionView::RecordIdentifier

  def new
    @session = Session.find(params[:session_id]) if params[:session_id].present?
    @record = Record.new
  end

  def create
    @record = Record.create!(record_params)

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.prepend('records-table', partial: 'records/record',
          locals: { record: @record }))
      end
      # format.html { redirect_to(new_record_path(session_id: record_params[:session_id])) }
    end
  end

  def destroy
    record = Record.find(params[:id])
    record.destroy!

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.remove(dom_id(record)))
      end
    end
  end

  private

  def record_params
    params.require(:record).permit(:session_id, :time, :scramble)
  end
end
