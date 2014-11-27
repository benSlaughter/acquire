Before do |scenario|
 Acquire.start(scenario)
end

After do |scenario|
  Acquire.stop
end

at_exit do
  Acquire.finished
end