class Record < ApplicationRecord
  belongs_to :session

  validates :time, presence: true

  def display_time
    # format('%02d:%02d', ((time / 60) % 60), (time % 60))
    # time.to_s.reverse.scan(/.{1,2}/).join('.').reverse

    msec = (time % 1000).to_s.rjust(3, '0')[0, 2]
    sec = ((time / 1000) % 60).to_s
    min = ((time / 1000 / 60) % 60).to_s

    sec = sec.rjust(2, '0') if min != '0'

    chrono = [sec, msec].join('.')
    chrono = (min + ':' + chrono) if min != '0'

    chrono
  end
end
