- test3.lua
-- Answer call, play a prompt, hang up
-- Set the path separator
pathsep = '/'
-- Windows users do this instead:
-- pathsep = '\'
-- Answer the call
freeswitch.consoleLog("WARNING","Not yet answered\n")
session:answer()
freeswitch.consoleLog("WARNING","Already answered\n")
-- Create a string with path and filename of a sound file
prompt ="ivr" ..pathsep .."ivr-welcome_to_freeswitch.wav"
-- Play the prompt
freeswitch.consoleLog("WARNING","About to play '" .. prompt .."'\n")
session:streamFile(prompt)
freeswitch.consoleLog("WARNING","After playing '" .. prompt .."'\n")
-- Hangup
session:hangup()
freeswitch.consoleLog("WARNING","Afterhangup\n")
