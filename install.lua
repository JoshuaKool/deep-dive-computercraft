local function download(url, path)
    local response = http.get(url)
    if response then
        local content = response.readAll()
        response.close()
        local file = fs.open(path, "w")
        file.write(content)
        file.close()

        shell.run("reboot")
        
    else
        print("Failed to download " , path)
    end
end

download("https://raw.githubusercontent.com/JoshuaKool/deep-dive-computercraft/main/startup.lua", "startup.lua")
download("https://raw.githubusercontent.com/JoshuaKool/deep-dive-computercraft/main/loading.lua", "loading.lua")
download("https://raw.githubusercontent.com/JoshuaKool/deep-dive-computercraft/main/button.lua", "button.lua")

shell.run("startup.lua")