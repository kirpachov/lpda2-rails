# frozen_string_literal: true

def ignore_day_saving_time(time)
  time.dst? ? time - 1.hour : time
end

def ignore_dst(time)
  ignore_day_saving_time(time)
end
