-- You may subscribe to specific events if you want to, and even subclasses
-- con1 = freeswitch.EventConsumer("CUSTOM")
-- or
-- con2 = freeswitch.EventConsumer("CUSTOM","conference::maintenance")

--listen for an event specific subclass
con3 = freeswitch.EventConsumer("CUSTOM", "ping::running")

-- create an event in that specific subclass
event = freeswitch.Event("CUSTOM", "ping::running")
event:addHeader("hi", "there")
-- fire the event
event:fire()

-- look in the listened events stack for events to "pop" out, block there for max 20 seconds
received_event = con3:pop(1, 20000)
if(received_event) then
    stream:write("event received\n")
    stream:write(received_event:serialize("text"))
else  
    stream:write("no event\n")
end
