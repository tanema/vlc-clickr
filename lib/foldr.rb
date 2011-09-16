
class Foldr
	SUPPORTED_EXT = %w{ 3gp asf wmv au avi flv mov mp4 ogm ogg mkv mka ts mpg mp3 mp2 nsc nsv nut ra ram rm rv rmbv a52 dts aac flac dv vid tta dv vid tac ty wav dts xa m4a }
	
	def initialize(paths)
		@paths = paths
		initFoldr(@paths)
	end
	
	def initFoldr(paths)
		@contents = []
		paths.gsub('\\', '/').split(';').each do |path|
			contents = fileDrill(path)
			@contents.push(*contents) if contents.length > 0
		end
	end
	
	def reload
		initFoldr(@paths)
	end
	
	def contents
		@contents
	end

	def fileDrill(path, parent = nil)
		file_info = []
		path+="/*"
		files = Dir.glob(path)
		files.each do |file|
			newfile = Hash.new
			newfile[:isdir] = Dir.exist?(file)
			newfile[:parent] = (parent[:parent].nil? ? "" : parent[:parent] + '/') + parent[:name] unless parent.nil?
			newfile[:fullname] = file[file.rindex('/')+1, file.length]
			newfile[:name] = newfile[:isdir] ? newfile[:fullname] : newfile[:fullname][0, newfile[:fullname].rindex('.') || file.length]
			newfile[:path] = file
			newfile[:ext] = newfile[:fullname][newfile[:fullname].rindex('.')+1, newfile[:fullname].length] if !newfile[:isdir] && newfile[:fullname].rindex('.')
			newfile[:subdirs] = fileDrill(file, newfile) if newfile[:isdir]
			file_info.push(newfile) unless !newfile[:isdir] && !SUPPORTED_EXT.include?(newfile[:ext])
		end
		return file_info
	end
	
	def get_folder(path)
		return path.nil? ? @contents : get_folder_with_path(path, @contents)
	end
	
	def get_folder_with_path(path, directory)
		items = path.split('/')
		directory.each do |file|
			if file[:name] == items[0]
				if items.length == 1 
					queryfolder = fileDrill(file[:path])
					file[:subdirs] = queryfolder if file[:subdirs] != queryfolder
					return file
				else
					get_file(path.shift, file[:subdirs])
				end
			end
		end
		return nil;
	end
end