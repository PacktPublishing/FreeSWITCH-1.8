


# FreeSWITCH 1.8
This is the code repository for [FreeSWITCH 1.8](https://www.packtpub.com/networking-and-servers/freeswitch-1618-second-edition?utm_source=github&utm_medium=repository&utm_campaign=9781785889134), published by [Packt](https://www.packtpub.com/?utm_source=github). It contains all the supporting project files necessary to work through the book from start to finish.
## About the Book
FreeSWITCH is an open source telephony platform designed to facilitate the creation of voice and chat-driven products, scaling from a soft-phone to a PBX and even up to an enterprise-class soft-switch. This book introduces FreeSWITCH to IT professionals who want to build their own telephony system.


## Instructions and Navigation
All of the code is organized into folders. Each folder starts with a number followed by the application name. For example, Chapter02.

Chapters 01,03,04,07,13,14, and 15 does not have any code files.

The code will look like the following:
```
<extension name="get voicemail">
<condition field="destination_number" expression="^\*98$">
<action application="answer"/>
<action application="voicemail"
      data="check auth default${domain_name}"/>
</condition>
</extension>
```

At the very least you will need a computer on which you can run FreeSWITCH. Typically this is a server although that isn't an absolute requirement. You will also need at least a couple SIP devices, be them softphones or desk phones, and a couple browsers as WebRTC clients.

## Related Products
* [FreeSWITCH 1.6 Cookbook](https://www.packtpub.com/networking-and-servers/freeswitch-16-cookbook?utm_source=github&utm_medium=repository&utm_campaign=9781785280917)

* [Mastering FreeSWITCH](https://www.packtpub.com/networking-and-servers/mastering-freeswitch?utm_source=github&utm_medium=repository&utm_campaign=9781784398880)

* [FreeSWITCH 1.0.6](https://www.packtpub.com/networking-and-servers/freeswitch-106?utm_source=github&utm_medium=repository&utm_campaign=9781847199966)

### Download a free PDF

 <i>If you have already purchased a print or Kindle version of this book, you can get a DRM-free PDF version at no cost.<br>Simply click on the link to claim your free PDF.</i>
<p align="center"> <a href="https://packt.link/free-ebook/9781785889134">https://packt.link/free-ebook/9781785889134 </a> </p>