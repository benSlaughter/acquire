require 'hashie'

Before do |scenario|
  @test = Hashie::Mash.new(s: scenario, p: [], m: [], c: [])

  @trace ||= TracePoint.trace(:call) do |tp|
    if tp.path.include?("/qa-brandwatch-ui/")
      @test.p << tp.path
      @test.m << tp.method_id
      @test.c << tp.defined_class
    end
  end

  @trace.enable
end

After do |scenario|
  @trace.disable

  @scenario_stuff ||= []
  @scenario_stuff.push Hashie::Mash.new(scenario: @test.s.file_colon_line, paths: @test.p.uniq)
end