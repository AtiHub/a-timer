class ScramblesController < ApplicationController
  def show
    @category = category
    @scramble = Scrambler.new.send(@category)
  end

  private

  def category
    return Scrambler::CATEGORIES.first if params[:category].blank?

    raise 'Invalid Category' if Scrambler::CATEGORIES.exclude?(params[:category])

    params[:category]
  end
end
