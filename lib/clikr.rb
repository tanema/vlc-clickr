require 'net/telnet'

VLC_COMMAND=%{vlc --extraintf rc --rc-host localhost:4444 --fullscreen}

class Clickr

	def initialize
		start_vlc
		@paused = false
		@telnet = nil
		begin
			@telnet = Net::Telnet.new( "Host" => "localhost", "Port" => 4444, "TelnetMode" => false, "Prompt" => //)
			puts "Connection accepted."
		rescue Exception => e
			puts "Failed to connect to VLC, retrying ..."
			sleep 1
			retry
		end
	end
  
	def start_vlc
		@vlc_thread = Thread.new do
			system VLC_COMMAND
		end
	end

	def cmd(cmd_str)
		@telnet.cmd(cmd_str)
	end
  
	def play
		pause if @paused
		cmd("play")
	end
  
	def pause
		@paused = !@paused
		cmd("pause")
	end
  
	def nxt
		cmd("next")
	end
  
	def prev
		cmd("prev")
	end
  
	def stop
		play if @paused
		cmd("stop")
	end
  
	def add(item)
		cmd("add #{item}")
	end
  
	def enqueue(item)
		cmd("enqueue #{item}")
	end

	def playlist
		cmd("playlist")
	end
  
	#goto item in playlist
	def goto(x)
		cmd("goto #{x}")
	end
  
	def repeat(on)
		cmd("repeat #{ on ? "on" : "off"}")
	end

	def loop_it(on)
		cmd("loop #{ on ? "on" : "off"}")
	end

	def random(on)
		cmd("random #{ on ? "on" : "off"}")
	end

	def clear
		cmd("clear")
	end

	def status
		cmd("status")
	end

	def chapter(item)
		cmd("chapter #{item}")
	end

	def chapter_n
		cmd("chapter_n")
	end

	def chapter_p
		cmd("chapter_p")
	end

	def seek(seconds)
		cmd("seek #{seconds}")
	end

	def fastforward
		cmd("fastforward")
	end

	def rewind
		cmd("rewind")
	end

	def faster
		cmd("faster")
	end

	def slower
		cmd("slower")
	end

	def normal
		cmd("normal")
	end

	def frame
		cmd("frame")
	end

	def f(on)
		cmd("f #{ on ? "on" : "off"}")
	end

	def info
		cmd("info")
	end

	def stats
		cmd("stats")
	end

	def get_time
		cmd("get_time")
	end

	def is_playing
		cmd("is_playing")
	end

	def get_title
		cmd("get_title")
	end

	def get_length
		cmd("get_length")
	end

	def volume(x)
		cmd("volume #{x}")
	end

	def volup(x)
		cmd("volup #{x}")
	end

	def voldown(x)
		cmd("voldown #{x}")
	end

	def adev(x)
		cmd("adev #{x}")
	end

	def achan(x)
		cmd("achan #{x}")
	end

	def atrack(x)
		cmd("atrack #{x}")
	end

	def vtrack(x)
		cmd("vtrack #{x}")
	end

	def vratio(x)
		cmd("vratio #{x}")
	end

	def vcrop(x)
		cmd("vcrop #{x}")
	end

	def vzoom(x)
		cmd("vzoom #{x}")
	end

	def snapshot
		cmd("snapshot")
	end

	def strack(x)
		cmd("strack #{x}")
	end

	def key(key)
		cmd("key #{key}")
	end

	def menu(option)
		cmd("menu #{["on","off","up","down","left","right","select"][option]}") if option >= 0 && option <= 6
	end

	def terminate
		cmd("quit")
		exit
	end

end