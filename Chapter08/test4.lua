freeswitch.consoleLog("WARNING","Before first call\n")
first_session = freeswitch.Session("user/1011")
if (first_session:ready()) then  
        freeswitch.consoleLog("WARNING","first leg answered\n")
        second_session = freeswitch.Session("user/1010")  
        if (second_session:ready()) then
                freeswitch.consoleLog("WARNING","second leg answered\n")  
                freeswitch.bridge(first_session, second_session)
                freeswitch.consoleLog("WARNING","After bridge\n")  
        else
                freeswitch.consoleLog("WARNING","second leg failed\n")  
        end
else  
        freeswitch.consoleLog("WARNING","first leg failed\n")
end
