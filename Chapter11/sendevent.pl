#!/usr/bin/perl
require ESL;

my $con = ESL::ESLconnection->new("localhost", "8021", "ClueCon");
my $e = ESL::ESLevent->new("SEND_MESSAGE");

$e->addHeader("Content-Type", "text/plain");
$e->addHeader("User", '1001');
$e->addHeader("profile", 'internal');
$e->addHeader("host", 'lab.opentelecomsolutions.com');
$e->addBody("ciao a tutti3");
$con->sendEvent($e);
