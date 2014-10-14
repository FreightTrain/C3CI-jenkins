require 'tmpdir'

module Jenkins

  class Cli

    def run(cmd)
      result = %x{/var/vcap/packages/java/bin/java -jar #{cli_path} -s http://localhost:8088/ #{cmd}}
      raise "Problem running jenkins cli" unless $?.success?
      result
    end

    private

    def cli_path
      "#{Dir.tmpdir}/jenkins-cli.jar"
    end

  end

end
