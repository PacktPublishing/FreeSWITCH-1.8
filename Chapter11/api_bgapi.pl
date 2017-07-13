#!/usr/bin/perl
require ESL;

my $con = ESL::ESLconnection->new("localhost", "8021", "ClueCon");

$con->api('chat', "sip|1011\@lab.opentelecomsolutions.com|1001\@lab.opentelecomsolutions.com|ciao a tutti1|text/plain");
$con->bgapi('chat', "sip|1011\@lab.opentelecomsolutions.com|1001\@lab.opentelecomsolutions.com|ciao a tutti2|text/plain");
