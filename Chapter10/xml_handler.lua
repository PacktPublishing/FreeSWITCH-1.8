xml_snippet = [[
<?xml version="1.0" encoding="UTF-8" standalone="no"?>  
<document type="freeswitch/xml">
 <section name="directory">
  <domain name="lab.opentelecomsolutions.com">
   <params>
    <param name="dial-string" value="{^^:sip_invite_domain=${dialed_domain}:presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(*/${dialed_user}@${dialed_domain})}"/>
   </params>
   <user id="1000">
    <params>
     <param name="password" value="56789"/>
     <param name="vm-password" value="56789"/>
    </params>
    <variables>
     <variable name="accountcode" value="1000"/>
     <variable name="user_context" value="default"/>
     <variable name="effective_caller_id_name" value="Giovanni Maruz"/>
     <variable name="effective_caller_id_number" value="1000"/>
     <variable name="outbound_caller_id_name" value="OpenTelecom.IT"/>
     <variable name="outbound_caller_id_number" value="+393472665618"/>
    </variables>
   </user>
   <user id="1001">
    <params>
     <param name="password" value="56789"/>
     <param name="vm-password" value="56789"/>
    </params>
    <variables>
     <variable name="accountcode" value="1001"/>
     <variable name="user_context" value="default"/>
     <variable name="effective_caller_id_name" value="Sara Sissi"/>
     <variable name="effective_caller_id_number" value="1001"/>
     <variable name="outbound_caller_id_name" value="OpenAdassi.IR"/>
     <variable name="outbound_caller_id_number" value="+12125551212"/>
    </variables>
   </user>
  </domain>
 </section>
</document>
]]
XML_STRING = xml_snippet

freeswitch.consoleLog("notice", XML_STRING .. "\n")
