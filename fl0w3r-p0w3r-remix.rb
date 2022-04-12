##| fl0w3r_p0w3r (live_coded_remix)
##| variable_j

use_bpm 168

# samples can be found at
# https://drive.google.com/drive/folders/12ir__D_uZZ2sdqLK0A3HGO5g3xBIUf4b?usp=sharing

flower1 = "/path/to/my/samples/flower1.wav"
flower2 = "/path/to/my/samples/flower2.wav"
flower3 = "/path/to/my/samples/flower3.wav"
flower4 = "/path/to/my/samples/flower4.wav"
flower5 = "/path/to/my/samples/flower5.aif"
flower6 = "/path/to/my/samples/flower6.wav"
flower7 = "/path/to/my/samples/flower7.wav"
drums = "/path/to/my/samples/bee-drum.wav"
drums2 = "/path/to/my/samples/bee-drum2.wav"
bees_and_birds = "/path/to/my/samples/bees.aif"
birds_and_bees = "/path/to/my/samples/birds.wav"


stopBool = false
stopBool2 = true

cutoffA = 130
cutoffB = 130
cutoffC = 130
cutoffD = 130


##| set_mixer_control! lpf: 30, lpf_slide: 48

##| reset_mixer!


##| ***
##| CLICK TRACK
##| ***
live_loop :click do
  ##| play note :d4
  sleep 1
end

live_loop :click2, sync: :click  do
  sleep 4
end


##| ***
##| GUITARS
##| ***
live_loop :flower1, sync: :click2 do
  if stopBool
    stop
  end
  
  speed = -0.5
  start = 0
  finish = 1
  
  use_sample_defaults beat_stretch: 28, rate: speed, amp: 1.25, amp_slide: 16, cutoff: cutoffA, pan: -0.25, start: start, finish: finish
  samp = sample flower1
  control samp
  sleep 28 # happy accident
end

with_fx :slicer, phase: 0.5, mix: 1 do
  live_loop :flower2, sync: :flower1 do
    if stopBool
      stop
    end
    
    speed = 0.5
    
    use_sample_defaults rate: speed, amp: 0.90, amp_slide: 16, cutoff: cutoffA, pan: 0.25
    samp = sample flower2
    control samp
    sleep sample_duration flower2
  end
end


with_fx :flanger, phase: 2, mix: 1 do
  live_loop :flower3, sync: :flower1 do
    stop
    
    use_sample_defaults rate: 1, amp: 0.95, cutoff: cutoffA
    sample flower3
    sleep 10
  end
end


##| ***
##| GUITARS B
##| ***
with_fx :slicer, phase: 0.5, mix: 1 do
  live_loop :flower4, sync: :flower1 do
    stop
    
    use_sample_defaults beat_stretch: 28, rate: 1, amp: 0.1, cutoff: cutoffB, amp_slide: 28
    samp = sample flower4
    control samp, amp: 1
    sleep sample_duration flower4
  end
end

with_fx :flanger, phase: 2 do
  with_fx :ping_pong, phase: 4, mix: 0.5, amp: 0.75 do
    live_loop :flower5, sync: :flower4 do
      stop
      
      use_sample_defaults beat_stretch: 56, rate: 1, amp: 0.35, cutoff: cutoffB
      sample flower5
      sleep sample_duration flower5
    end
  end
end


##| ***
##| BREAKDOWN
##| ***
with_fx :slicer, phase: 4, mix: 1 do
  live_loop :flower6, sync: :flower4 do
    if stopBool2
      stop
    end

    use_sample_defaults rate: 1, amp: 0.8, beat_stretch: 64, start: 0, finish: 0.5, cutoff: cutoffC
    sample flower6
    sleep sample_duration flower6
  end
  
  live_loop :flower8, sync: :flower6 do
    stop
    
    use_sample_defaults beat_stretch: 64, rate: 1, amp: 0.6, pan: 0.25, start: 0, finish: 0.5, cutoff: 10
    sample flower7
    sleep sample_duration flower7
  end
end


with_fx :slicer, phase: 2 do
  live_loop :flower7, sync: :flower6 do
    if stopBool2
      stop
    end
    
    
    use_sample_defaults beat_stretch: 64, rate: 1, amp: 0.6, cutoff: cutoffC, pan: -0.25, amp_slide: 16, start: 0, finish: 0.5
    control sample flower7, amp: 1
    sleep sample_duration flower7
  end
end



##| ***
##| FX
##| ***
live_loop :bees_and_birds, sync: :click do
  ##| stop
  
  use_sample_defaults rate: 1
  sample bees_and_birds
  sleep sample_duration bees_and_birds
end

##| sample bees_and_birds, amp: 1

##| ***
##| DRUMS
##| ***
with_fx :lpf, cutoff: 120 do
  live_loop :drums, sync: :flower1 do
    if stopBool
      stop
    end
    
    slice_idx = rand_i(16)
    slice_size = 0.0625
    s = slice_idx * slice_size
    f = s + slice_size
    
    speed = 0.5
    
    start = 0 #s
    finish = 1 #f
    
    use_sample_defaults beat_stretch: 16, rate: speed, cutoff: cutoffD, start: start, finish: finish
    samp = sample drums
    control samp
    sleep sample_duration drums
  end
  
  live_loop :drumsB, sync: :flower4 do
    stop
    
    speed = 1
    
    use_sample_defaults beat_stretch: 16, rate: speed, cutoff: cutoffD, start: 0, finish: 1
    samp = sample drums
    control samp
    sleep sample_duration drums
  end
  
  live_loop :drums2, sync: :click do
    if stopBool2
      stop
    end
    
    speed = 0.5
    
    use_sample_defaults beat_stretch: 16, rate: speed, start: 0, finish: 1, cutoff: cutoffC
    sample drums2
    sleep sample_duration drums2
  end
end

live_loop :hats, sync: :flower7 do
  stop
  
  use_sample_defaults amp: 1, attack: 0.01, decay: 0.01, sustain: 0, release: 0
  a = (ring 0,1,0,2,2,0).choose
  case a
  when 0
    8.times do
      sample :drum_cymbal_closed
      sleep 0.5
    end
  when 1
    8.times do
      sample :drum_cymbal_closed
      sleep 0.25
    end
  when 2
    2.times do
      sample :drum_cymbal_closed
      sleep 0.3
      sample :drum_cymbal_closed
      sleep 0.3
      sample :drum_cymbal_closed
      sleep 0.4
    end
  end
end
