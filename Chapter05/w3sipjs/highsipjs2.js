'use strict';
var cur_call = null;
var ua;
var chatting_with = false;


function onTerminated() {

    $("#content").show();
    $("#ask").show();
    $("#cidname").hide();
    $("#hupbtn").hide();
    $("#chatwin").hide();
    $("#chatmsg").hide();
    $("#chatsend").hide();
    $("#backbtn").show();
    $("#webcam").hide();
    $("#video1").hide();
    $("#login").hide();
    $("#loginbtn").hide();
    $("#callbtn").show();
    $("#ext").show();
    $("#ext").focus();

    if (cur_call) {
        cur_call.terminate();
        cur_call = null;
    }

    chatting_with = false;
    console.error("terminated");
}


function onAccepted() {
    chatting_with = true;
    $("#chatwin").html("");

    $("#content").hide();
    $("#ask").hide();
    $("#br").hide();
    $("#backbtn").hide();
    $("#ext").hide();
    $("#callbtn").hide();
    $("#cidname").hide();
    $("#hupbtn").show();
    $("#chatwin").hide();
    $("#chatmsg").hide();
    $("#chatsend").hide();
    if (chatting_with) {

        $("#chatwin").show();
        $("#chatmsg").show();
        $("#chatsend").show();
    }
    $("#webcam").show();
    $("#video1").show();
    console.error("accepted");

}

function handleInvite(s) {

    cur_call = s;

    s.accept({
        media: {
            constraints: {
                audio: true,
                video: true
            },
            render: {
                remote: document.getElementById('webcam')
            }
        }
    });
    $("#ext").val(s.remoteIdentity.uri.toString());
    cur_call.on('accepted', onAccepted.bind(cur_call));
    cur_call.once('bye', onTerminated.bind(cur_call));
    cur_call.once('failed', onTerminated.bind(cur_call));
    cur_call.once('cancel', onTerminated.bind(cur_call));
    $("#chatwin").html("");
}



function receiveMessage(e) {
    var body = e.body;
    var from = e.remoteIdentity.uri.user;

    if (body.slice(-1) !== "\n") {
        body += "\n";
    }
    if (from.slice(0,6) == "verto+") {
        from = from.slice(6);
    }

    $('#chatwin')
        .append(from + ': ')
        .append(body)
    $('#chatwin').animate({
        "scrollTop": $('#chatwin')[0].scrollHeight
    }, "fast");
}

































































function docall() {
    if (cur_call) {
        cur_call.terminate();
        cur_call = null;
    }

    cur_call = ua.invite($("#ext").val(), {
        media: {
            constraints: {
                audio: true,
                video: true
            },
            render: {
                remote: document.getElementById('webcam')
            }
        }
    });
    cur_call.on('accepted', onAccepted.bind(cur_call));
    cur_call.once('bye', onTerminated.bind(cur_call));
    cur_call.once('failed', onTerminated.bind(cur_call));
    cur_call.once('cancel', onTerminated.bind(cur_call));

}

$("#callbtn").click(function() {
    if ($("#ext").val()) {
        docall();
    }
});

$("#hupbtn").click(function() {
    if (cur_call) {
        cur_call.terminate();
    }

    chatting_with = false;
    $("#br").show();
    $("#ext").show();
    $("#ext").focus();
});

$("#loginbtn").click(function() {
    if ($("#login").val()) {
        init();
        $("#loginbtn").hide();
        $("#login").hide();
        $("#cidname").show();
        $("#callbtn").show();
        $("#backbtn").show();
        $("#br").show();
        $("#ext").show();
        $("#ext").focus();
    }
});




$("#backbtn").click(function() {
    $("#login").show();
    $("#loginbtn").show();
    $("#ext").hide();
    $("#cidname").hide();
    $("#callbtn").hide();
    $("#hupbtn").hide();
    $("#chatwin").hide();
    $("#chatmsg").hide();
    $("#chatsend").hide();
    $("#backbtn").hide();
    cur_call = null;
    chatting_with = false;

});

function setupChat() {
    $("#chatwin").html("");

    $("#chatsend").click(function() {
        if (!cur_call && chatting_with) {
            return;
        }

        ua.message($("#ext").val(), $("#chatmsg").val());




        $("#chatmsg").val("");
    });

    $("#chatmsg").keyup(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            $("#chatsend").trigger("click");
            }
    });

    ua.on('message', receiveMessage);
    ua.on('invite', handleInvite);
}


function init() {
    cur_call = null;
    chatting_with = false;

    var nameHost;
    var which_server;

    nameHost = window.location.hostname;

    which_server = "wss://" + nameHost + ":" + "3384";
    console.error("which_server=", which_server);

    ua = new SIP.UA({
        wsServers: which_server,
        uri: $("#login").val() + "@" + nameHost,
        password: $("#passwd").val(),
        userAgentString: 'SIP.js/0.7.7 Sara',
        traceSip: true,
    });

    $("#cidname").keyup(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            $("#callbtn").trigger("click");
        }
    });

    setupChat();

    $(document).keypress(function(event) {
        var key = String.fromCharCode(event.keyCode || event.charCode);
        var i = parseInt(key);
        var tag = event.target.tagName.toLowerCase();

        if (tag != 'input') {
            if (key === "#" || key === "*" || key === "0" || (i > 0 && i <= 9)) {
                cur_call.dtmf(key);
            }
        }
    });
}

$(window).load(function() {
    cur_call = null;
    chatting_with = false;
    $("#conference").show();
    $("#ext").hide();
    $("#backbtn").hide();
    $("#cidname").hide();
    $("#callbtn").hide();
    $("#hupbtn").hide();
    $("#chatwin").hide();
    $("#chatmsg").hide();
    $("#chatsend").hide();
    $("#webcam").hide();
    $("#video1").hide();
    $("#login").keyup(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            $("#loginbtn").trigger("click");
        }
    });

    $("#ext").keyup(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            $("#callbtn").trigger("click");
        }
    });
});
