#!/usr/bin/perl
require ESL;

my $type = ".*";
my $header = ".*";
my $value = ".*";

#$type = "CUSTOM|CHANNEL.*|MESSAGE";
#$header = "Core-UUID|Event-Subclass|Channel-State|Channel-Call-State";
#$value = "HANGUP|ACTIVE|DOWN|CS_EXECUTE";

my $con = new ESL::ESLconnection("localhost", "8021", "ClueCon");
$con->events("plain", "all");

while($con->connected()) {
        my $e = $con->recvEvent();
        if ($e) {
                if(! ($e->getType() =~ /^($type)$/) ) {
                        next;
                }
                printf "Type: [%s]\n", $e->getType();
                my $h = $e->firstHeader();
                while ($h) {
                        if( ( $h =~ /^($header)$/) && ($e->getHeader($h) =~ /^($value)$/) ){
                                printf "Header: [%s] = [%s]\n", $h, $e->getHeader($h);
                        }
                        $h = $e->nextHeader();
                }
                printf "Body: [%s]\n\n", $e->getBody;
        }
}
