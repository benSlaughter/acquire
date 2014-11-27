require 'hashie'
require 'acquire/hooks'

module Acquire
  @test_data = Hashie::Mash.new

  class << self
    def config
      @config ||= Hashie::Mash.new()
    end

    def configure
      yield config
    end

    def location
      config.path + "/" + config.folder
    end

    def trace
      @trace ||= TracePoint.trace(:call) do |tp|
        if tp.path.include?(config.path + "/" + config.folder)
          @temporary_data.trace_paths << tp.path
          @temporary_data.trace_methods << tp.method_id
          @temporary_data.trace_classes << tp.defined_class
        end
      end
    end

    def start(scenario)
      @temporary_data = Hashie::Mash.new(
        scenario: scenario,
        trace_paths:[],
        trace_methods:[],
        trace_classes:[]
      )

      trace.enable
    end

    def stop
      trace.disable

      @temporary_data.trace_paths.each do |path|
        path = path.gsub(config.path + "/", "")
        if path.end_with? ".feature"
          next
        else
          @test_data[path] ||= Hashie::Mash.new
          @test_data[path][@temporary_data.scenario.file] ||= []
          @test_data[path][@temporary_data.scenario.file] << @temporary_data.scenario.line unless @test_data[path][@temporary_data.scenario.file].include? @temporary_data.scenario.line
        end
      end
    end

    def finished
      File.open('test.yml', 'w') {|f| f.write @test_data.to_yaml }
    end

  end
end

Acquire.configure do |config|
  config.path   = Dir.pwd
  config.folder = "lib"
end
