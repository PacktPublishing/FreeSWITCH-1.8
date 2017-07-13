freeswitch.consoleLog("WARNING","before creating the API object\n")  
api = freeswitch.API()  
freeswitch.consoleLog("WARNING","after creating the API object\n")  
reply = api:executeString("version")
freeswitch.consoleLog("WARNING","reply is: " .. reply .."\n")
reply = api:executeString("status")
freeswitch.consoleLog("WARNING","reply is: " .. reply .."\n")
reply = api:executeString("sofia status")
freeswitch.consoleLog("WARNING","reply is: " .. reply .."\n")
reply = api:executeString("bgapi originate user/1011 5000")
-- reply = api:executeString("originate user/1011 5000")
freeswitch.consoleLog("WARNING","reply is: " .. reply .."\n")
counter = 0
while(counter < 20) do
        reply = api:executeString("show channels")
        freeswitch.consoleLog("WARNING","reply #" .. counter .. " is: " .. reply .."\n")
        counter = counter + 1
        api:executeString("msleep 1000")
end
freeswitch.consoleLog("WARNING","about to hangup all calls in the server\n")
reply = api:executeString("hupall")
freeswitch.consoleLog("WARNING","reply is: " .. reply .."\n")
freeswitch.consoleLog("WARNING","GOODBYE (world)\n")
