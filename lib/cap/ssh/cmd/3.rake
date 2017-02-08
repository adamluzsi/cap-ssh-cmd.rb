class CapistranoSSH

  def initialize(cap)
    @cap = cap
  end

  def ssh
    server = get_server_by_user
    command = "ssh #{server.user}@#{[server.hostname, server.port].compact.join(':')}"
    Kernel.exec(command)
  end

  def scp(argv)
    server = get_server_by_user
    args = [argv[-2], argv[-1]].map { |str| str.sub(/^:/, "#{server.user}@#{server.hostname}:") }
    Kernel.exec("scp #{args.join(' ')}")
  end

  protected

  def find_servers
    servers = []
    @cap.instance_exec do
      on roles(:all) do |server|
        servers << server # server hostname should be in here
      end
    end
    return servers.sort_by{ |s| s.hostname }
  end


  def get_server_by_user

    list = find_servers
    return list.first if list.length == 1

    require 'io/console'

    server = nil
    $stdout.puts('Please choose a server address:')
    list.each.with_index do |element, index|
      $stdout.puts("\t#{index + 1}:\t#{element}")
    end

    loop do

      begin

        raw_input = $stdin.getch.chomp

        exit(-1) if ["\x03", "\x04"].include?(raw_input)
        raise("selected server id was not an integer (#{raw_input})") unless raw_input =~ /\d+/

        chosen_index = raw_input.to_i - 1
        server = list[chosen_index]

        raise("Chosen server number is not valid: #{chosen_index + 1}") unless server
        break

      rescue => ex
        $stdout.puts(ex.message)
      end

    end

    return server

  end

end

desc 'open ssh console'
task :ssh do
  CapistranoSSH.new(self).ssh
end

desc 'execute scp command, use ":" as begining to represent remote server address'
task :scp do
  CapistranoSSH.new(self).scp(ARGV)
end
