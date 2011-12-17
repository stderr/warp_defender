module Ease

  def Ease.linear(time, start, change, duration)
    return change*time/duration.to_f + start
  end

  def Ease.in_sine(time, start, change, duration)
    return -change * Math.cos(time/duration.to_f * (Math::PI/2)) + change + start
  end

  def Ease.out_sine(time, start, change, duration)
    return change * Math.sin(time/duration.to_f * (Math::PI/2)) + start
  end

  def Ease.inout_sine(time, start, change, duration)
    return -change/2.0 * (Math.cos(Math::PI*time/duration.to_f) - 1) + start
  end

  def Ease.in_quad(time, start, change, duration)
    time /= duration.to_f
    return change * time * time + start
  end

  def Ease.out_quad(time, start, change, duration)
    time /= duration.to_f
    return -change * time * (time-2) + start
  end

  def Ease.inout_quad(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change/2.0*time*time + start
    end
    --time
    return -change/2.0 * (time*(time-2) - 1) + start
  end

  def Ease.in_cubic(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time + start
  end

  def Ease.out_cubic(time, start, change, duration)
    time = time / duration.to_f - 1
    return change * (time*time*time + 1) + start
  end

  def Ease.inout_cubic(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * time*time*time + start
    end
    time -= 2
    return change / 2.0 * (time*time*time + 2) + start
  end

  def Ease.in_quart(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time*time + start
  end

  def Ease.out_quart(time, start, change, duration)
    time = time/duration.to_f-1
    return -change * (time*time*time*time - 1) + start
  end

  def Ease.inout_quart(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * (time*time*time*time) + start
    end
    time -= 2
    return -change/2.0 * (time*time*time*time - 2) + start
  end

  def Ease.in_quint(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time*time*time + start
  end

  def Ease.out_quint(time, start, change, duration)
    time = time / duration.to_f - 1
    return change * (time*time*time*time*time + 1) + start
  end

  def Ease.inout_quint(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * time*time*time*time*time + start
    end
    time -= 2
    return change / 2.0 * (time*time*time*time*time + 2) + start
  end

  def Ease.in_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    return (time == 0) ? start : change * (2.0**(10 * (time/duration.to_f - 1))) + start
  end

  def Ease.out_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    return (time == duration) ? start + change : change * (-(2.0**(-10 * time/duration.to_f)) + 1) + start
  end

  def Ease.inout_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    if time == duration
      return start+change
    end

    time /= duration/2.0
    if time < 1
      return change/2.0 * (2.0**(10 * (time - 1))) + start
    end

    return change/2.0 * (-(2.0**(-10 * (time - 1))) + 2) + start
  end

# def Ease.in_circ(time, start, change, duration)
# {
# 	time /= duration
# 	return -change * (std::sqrt(1 - time*time) - 1) + start
# }
# 
# def Ease.out_circ(time, start, change, duration)
# {
# 	time /= duration-1
# 	wxLogDebug(wxString() << "change: " << change << " time: " << time << " start: " << start)
# 	return change * std::sqrt(1 - time*time) + start
# }
# 
# def Ease.inout_circ(time, start, change, duration)
# {
# 	time /= duration/2
# 	if(time < 1)
# 		return -change/2 * (std::sqrt(1 - time*time) - 1) + start
# 	time -= 2
# 	return change/2 * (std::sqrt(1 - time*time) + 1) + start
# }

  def Ease.in_elastic_default(time, start, change, duration)
    return Ease.in_elastic(time, start, change, duration, change, duration*0.3)
  end

  def Ease.in_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration.to_f
    if time == 1
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    time -= 1
    return -(a*(2.0**(10 * time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)) + start
  end

  def Ease.out_elastic_default(time, start, change, duration)
    return Ease.out_elastic(time, start, change, duration, change, duration*0.3)
  end

  def Ease.out_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration.to_f
    if time == 1
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    return (a*(2.0**(-10 * time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f) + change + start)
  end

  def Ease.inout_elastic_default(time, start, change, duration)
    return Ease.inout_elastic(time, start, change, duration, change, duration*0.3*1.5)
  end

  def Ease.inout_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration/2.0
    if time == 2
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    if time < 1
      time -= 1
      return -0.5*(a*(2.0**(10*time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)) + start
    end

    time -= 1
    return a*(2.0**(-10*time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)*0.5 + change + start
  end

  def Ease.in_back_default(time, start, change, duration)
    return Ease.in_back(time, start, change, duration, 1.70158)
  end

  def Ease.in_back(time, start, change, duration, s)
    time /= duration.to_f
    return change * time*time*((s+1)*time - s) + start
  end

  def Ease.out_back_default(time, start, change, duration)
    return Ease.out_back(time, start, change, duration, 1.70158)
  end

  def Ease.out_back(time, start, change, duration, s)
    time = time/duration.to_f-1
    return change * (time*time*((s+1)*time + s) + 1) + start
  end

  def Ease.inout_back_default(time, start, change, duration)
    return Ease.inout_back(time, start, change, duration, 1.70158)
  end

  def Ease.inout_back(time, start, change, duration, s)
    time /= duration/2.0
    if time < 1
      return change/2.0*(time*time*(((s*=(1.525))+1)*time - s)) + start
    end

    time -= 2
    return change/2.0*(time*time*(((s*=(1.525))+1)*time + s) + 2) + start
  end

  def Ease.in_bounce(time, start, change, duration)
    return change - Ease.out_bounce(duration - time, 0, change, duration) + start
  end

  def Ease.out_bounce(time, start, change, duration)
    time /= duration.to_f
    if time < 1/2.75
      return change*(7.5625*time*time) + start
    elsif time < 2/2.75
      time -= 1.5/2.75
      return change * (7.5625*time*time + 0.75) + start
    elsif time < 2.5/2.75
      time -= 2.25/2.75
      return change * (7.5625*time*time + 0.9375) + start
    else
      time -= 2.625/2.75
      return change * (7.5625*time*time + 0.984375) + start
    end
  end

  def Ease.inout_bounce(time, start, change, duration)
    if time < duration/2.0
      return Ease.in_bounce(time*2, 0, change, duration) * 0.5 + start
    else
      return Ease.out_bounce(time*2-duration, 0, change, duration) * 0.5 + change*0.5 + start
    end
  end

  def Ease.ease(easing, time, start, change, duration)

    case easing
    when "linear"
      Ease.linear(time, start, change, duration)
    when "sine in"
      Ease.in_sine(time, start, change, duration)
    when "sine out"
      Ease.out_sine(time, start, change, duration)
    when "sine inout"
      Ease.inout_sine(time, start, change, duration)
    when "quad in"
      Ease.in_quad(time, start, change, duration)
    when "quad out"
      Ease.out_quad(time, start, change, duration)
    when "quad inout"
      Ease.inout_quad(time, start, change, duration)
    when "cubic in"
      Ease.in_cubic(time, start, change, duration)
    when "cubic out"
      Ease.out_cubic(time, start, change, duration)
    when "cubic inout"
      Ease.inout_cubic(time, start, change, duration)
    when "quart in"
      Ease.in_quart(time, start, change, duration)
    when "quart out"
      Ease.out_quart(time, start, change, duration)
    when "quart inout"
      Ease.inout_quart(time, start, change, duration)
    when "quint in"
      Ease.in_quint(time, start, change, duration)
    when "quint out"
      Ease.out_quint(time, start, change, duration)
    when "quint inout"
      Ease.inout_quint(time, start, change, duration)
    when "expo in"
      Ease.in_expo(time, start, change, duration)
    when "expo out"
      Ease.out_expo(time, start, change, duration)
    when "expo inout"
      Ease.inout_expo(time, start, change, duration)
    #when "circ in"
      #Ease.in_circ(time, start, change, duration)
    #when "circ out"
      #Ease.out_circ(time, start, change, duration)
    #when "circ inout"
      #Ease.inout_circ(time, start, change, duration)
    when "elastic in"
      Ease.in_elastic_default(time, start, change, duration)
    when "elastic out"
      Ease.out_elastic_default(time, start, change, duration)
    when "elastic inout"
      Ease.inout_elastic_default(time, start, change, duration)
    when "back in"
      Ease.in_back_default(time, start, change, duration)
    when "back out"
      Ease.out_back_default(time, start, change, duration)
    when "back inout"
      Ease.inout_back_default(time, start, change, duration)
    when "bounce in"
      Ease.in_bounce(time, start, change, duration)
    when "bounce out"
      Ease.out_bounce(time, start, change, duration)
    when "bounce inout"
      Ease.inout_bounce(time, start, change, duration)
    end

  end
end
