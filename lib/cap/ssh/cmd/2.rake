get_server_by_user = lambda do

  list = [*find_servers_for_task(current_task)]
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

desc 'open ssh console'
task :ssh do
  server ||= get_server_by_user.call()
  exec "ssh #{user}@#{server.host}"
end

desc 'execute scp command, use ":" as begining to represent remote server address'
task :scp do
  server ||= get_server_by_user.call()
  args = [ARGV[-2], ARGV[-1]].map { |str| str.sub(/^:/, "#{user}@#{server.host}:") }
  exec "scp #{args.join(' ')}"
end
