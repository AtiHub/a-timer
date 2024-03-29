module ApplicationHelper
  def avg5(array)
    return '-' if array.size != 5

    display_time(array.sort[1..3].sum / 3)
  end

  def avg12(array)
    return '-' if array.size != 12

    display_time(array.sort[1..10].sum / 10)
  end

  def display_time(time)
    msec = (time % 1000).to_s.rjust(3, '0')[0, 2]
    sec = ((time / 1000) % 60).to_s
    min = ((time / 1000 / 60) % 60).to_s

    sec = sec.rjust(2, '0') if min != '0'

    chrono = [sec, msec].join('.')
    chrono = (min + ':' + chrono) if min != '0'

    chrono
  end
end
