conference_call_session = NIL
first_time_main_menu = false
first_time_submenu = false

api = freeswitch.API()
is_a_demo_user_extension = "false"
-----------------------------------------------------------------------
session:answer()
session:execute("playback", "silence_stream://1000")

if(not session:ready())then goto END end  
digits = session:playAndGetDigits (1,4,1,10000,
		'#','phrase:demo_ivr_main_menu',
		'ivr/ivr-that_was_an_invalid_entry.wav',
		'^\\d$|^10[01][0-9]$','digits',2000)
first_time_main_menu = true
goto MAIN_MENU_OPTIONS
-----------------------------------------------------------------------
::MAIN_MENU_SECOND_TIME::
if(not session:ready())then goto END end
if(conference_call_session) then goto END end  
digits = session:playAndGetDigits (1,4,2,10000,
		'#','phrase:demo_ivr_main_menu_short',
		'ivr/ivr-that_was_an_invalid_entry.wav',
		'^\\d$|^10[01][0-9]$','digits',2000)
first_time_main_menu = false
goto MAIN_MENU_OPTIONS
-----------------------------------------------------------------------
::MAIN_MENU_OPTIONS::
if(not session:ready())then goto END end
if(conference_call_session) then goto END end
if(digits == "") then
        freeswitch.consoleLog("WARNING", "No digits!\n")
elseif(digits == "1") then
        conference_call_session = freeswitch.Session(
		"sofia/internal/888@conference.freeswitch.org")

        if(conference_call_session:ready()) then
                conference_call_session:execute("playback", "silence_stream://1000")
                if(not session:ready())then goto END end
                if(not conference_call_session:ready())then goto END end
                freeswitch.bridge(session, conference_call_session)
        end
elseif(digits == "2") then
        session:execute("transfer", "9196 XML default")
elseif(digits == "3") then
        session:execute("transfer", "9664 XML default")
elseif(digits == "4") then
        session:execute("transfer", "9191 XML default")
elseif(digits == "5") then
        session:execute("transfer", "1234*256 enum")
elseif(digits == "6") then
        goto SUBMENU
else
        is_a_demo_user_extension = api:executeString(
		"regex " .. digits .. "|^(10[01][0-9])$")

        if(is_a_demo_user_extension == "true") then 
                session:execute("transfer", digits .. " XML features")
        end
end
if(first_time_main_menu) then goto MAIN_MENU_SECOND_TIME end
goto END
-----------------------------------------------------------------------
::SUBMENU::
if(not session:ready())then goto END end
digits = session:playAndGetDigits (1,1,1,5000,
		'#','phrase:demo_ivr_sub_menu',
		'ivr/ivr-that_was_an_invalid_entry.wav',
		'\\*','digits',2000)
first_time_submenu = true
goto SUBMENU_OPTIONS
-----------------------------------------------------------------------
::SUBMENU_SECOND_TIME::
if(not session:ready())then goto END end
digits = session:playAndGetDigits (1,1,2,5000,
		'#','phrase:demo_ivr_sub_menu_short',
		'ivr/ivr-that_was_an_invalid_entry.wav',
		'\\*','digits',2000)
first_time_submenu = false
goto SUBMENU_OPTIONS
-----------------------------------------------------------------------
::SUBMENU_OPTIONS::
if(not session:ready())then goto END end
if(digits == "") then
        freeswitch.consoleLog("WARNING", "No digits in submenu!\n")
elseif(digits == "*") then
        goto MAIN_MENU_SECOND_TIME
end
if(first_time_submenu) then goto SUBMENU_SECOND_TIME end
goto END
-----------------------------------------------------------------------
::END::
if(session:ready())then
        session:execute("playback", "voicemail/vm-goodbye.wav")
end
freeswitch.consoleLog("WARNING", "END!\n")

