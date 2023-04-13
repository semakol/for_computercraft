local dfpwm = require("cc.audio.dfpwm")
local speakers = { peripheral.find("speaker") }
local media = {...}

if media[1] == "help" then
term.clear()
print("--------------------")
print("==Kommands==")
print("play <name music>")
print("play help")
print("play list")
print("play info")
print(" ")
print("==Download Music?==")
print("1. cd media/")
print("2. wget <url> <name(.dfpwm)>")
print("3. cd /")
print("4. play <name music>")
print("--------------------")
elseif media[1] == "list" then
local list = fs.list("/media/")
term.clear()
print("--------------------")
print("==List Musics==")
for i = 1, #list do
print(list[i])
end
print("--------------------")
elseif media[1] == "info" then
term.clear()
print("--------------------")
print("==Information==")
print("Version: 1.0.1")
print("Created: Log")
print("Speakers: ".. #speakers)
print("--------------------")
else

local function play_speaker(speaker, buffer)
	while not speaker.playAudio(buffer, 3)  do
		os.pullEvent("speaker_audio_empty")
	end
end


local decoder = dfpwm.make_decoder()

while true do
for chunk in io.lines("media/"..media[1]..".dfpwm", 16 * 1024) do
local buffer = decoder(chunk)



funct = {}
for i = 1, #speakers do
	table.insert(funct, play_speaker(speakers[i], buffer))
end

term.clear()
print("Name: "..media[1])
print("---------------------")
print(buffer)
print("---------------------")



parallel.waitForAll(table.unpack(funct))
end
end
end

--this is a modification with any number of speakers from here https://www.youtube.com/watch?v=1VoicwqYv9k
