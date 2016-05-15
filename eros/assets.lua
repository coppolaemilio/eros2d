function load_dir(dir)
  local files = love.filesystem.getDirectoryItems(dir)
  for k, file in ipairs(files) do
    file = string.gsub(file, ".lua", "")
	  load_file(dir,file)
  end
end

function load_file(dir, fname)
  local FILE = dir .. "/" .. fname .. ".lua"

  printd("[+] Loading ".. dir .. ": ".. FILE )
  if love.filesystem.exists(FILE) then
    love.filesystem.load(FILE)()
  end
end