<?php
function not_found()
{
        Header("Content-type: text/xml");
        $xmlw = new XMLWriter();
        $xmlw -> openMemory();
        $xmlw -> setIndent(true);
        $xmlw -> setIndentString(' ');
        $xmlw -> startDocument('1.0', 'UTF-8', 'no');
        $xmlw -> startElement('document');
        $xmlw -> writeAttribute('type', 'freeswitch/xml');
        $xmlw -> startElement('section');
        $xmlw -> writeAttribute('name', 'result');
        $xmlw -> startElement('result');
        $xmlw -> writeAttribute('status', 'not found');
        $xmlw -> endElement(); //end result
        $xmlw -> endElement(); //end section
        $xmlw -> endDocument(); //end document
        echo $xmlw -> outputMemory();
        return TRUE;
}

function directory()
{  
        global $_SERVER;
        global $_POST;
# connect to MySQL
        $connect = mysql_connect("localhost", "root", "mysql_root_password");
        mysql_select_db("freeswitch", $connect) or die(mysql_error());

# Query 
        $query = "SELECT
                userid,password,displayname,vmpasswd,accountcode,outbound_caller_id_name,outbound_caller_id_number from extensions where userid='" . $_POST['user'] . "'";
# perform the query
        $result = mysql_query($query, $connect) or die(mysql_error());
        $num_rows = mysql_num_rows($result);

        if($num_rows==0){
# if no database row, fallback to filesystem, no FS error
                not_found();
                return TRUE;
        }
        Header("Content-type: text/xml");
        $xmlw = new XMLWriter();
        $xmlw -> openMemory();
        $xmlw -> setIndent(true);
        $xmlw -> setIndentString(' ');
        $xmlw -> startDocument('1.0', 'UTF-8', 'no');
        $xmlw -> startElement('document');
        $xmlw -> writeAttribute('type', 'freeswitch/xml');
        $xmlw -> startElement('section');
        $xmlw -> writeAttribute('name', 'directory');
        $xmlw -> startElement('domain');
        $xmlw -> writeAttribute('name','$${domain}');
        $xmlw -> startElement('params');
        $xmlw -> startElement('param');
        $xmlw -> writeAttribute('name', 'dial-string');
        $xmlw -> writeAttribute('value', '{^^:sip_invite_domain=$
                        {dialed_domain}:presence_id=${dialed_user}@${dialed_domain}}$
                        {sofia_contact(*/${dialed_user}@${dialed_domain})}');
        $xmlw -> endElement(); //end param
        $xmlw -> endElement(); //end param
        while( $row = mysql_fetch_array($result, MYSQL_ASSOC) ) {
                $xmlw -> startElement('user');
                $xmlw -> writeAttribute('id', $row['userid']);
                // Params
                $xmlw -> startElement('params');
                $xmlw -> startElement('param');
                $xmlw -> writeAttribute('name', 'password');
                $xmlw -> writeAttribute('value', $row['password']);
                $xmlw -> endElement();
                $xmlw -> startElement('param');
                $xmlw -> writeAttribute('name', 'vm-password');
                $xmlw -> writeAttribute('value', $row['vmpasswd']);
                $xmlw -> endElement();
                $xmlw -> endElement(); //end params
                // Variables
                $xmlw -> startElement('variables');
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'accountcode');
                $xmlw -> writeAttribute('value', $row['accountcode']);
                $xmlw -> endElement();
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'user_context');
                $xmlw -> writeAttribute('value', 'default');
                $xmlw -> endElement();
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'effective_caller_id_name');
                $xmlw -> writeAttribute('value', $row['displayname']);
                $xmlw -> endElement();
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'effective_caller_id_number');
                $xmlw -> writeAttribute('value', $row['userid']);
                $xmlw -> endElement();
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'outbound_caller_id_name');
                $xmlw -> writeAttribute('value', $row['outbound_caller_id_name']);
                $xmlw -> endElement();
                $xmlw -> startElement('variable');
                $xmlw -> writeAttribute('name', 'outbound_caller_id_number');
                $xmlw -> writeAttribute('value', $row['outbound_caller_id_number']);
                $xmlw -> endElement();
                $xmlw -> endElement(); //end variables
                $xmlw -> endElement(); //end user
        } // end while
        $xmlw -> endElement(); //end domain
        $xmlw -> endElement(); //end section
        $xmlw -> endDocument(); //end document
        echo $xmlw -> outputMemory();
        return TRUE;
}

if (isset($_POST['section'])) {
        if($_POST['section']=='directory') {
                directory();
        } else {
# if section is not directory, fallback to filesystem, no FS error
                not_found();
        }
}
?>
