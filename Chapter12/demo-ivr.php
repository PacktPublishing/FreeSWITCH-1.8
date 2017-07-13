<?php
require "../phttapi.php";

if ( array_key_exists( 'session_id', $_REQUEST ) ) {
    session_id( $_REQUEST['session_id'] );
}
session_start();

if ( array_key_exists( 'exiting', $_REQUEST ) ) {
    header( 'Content-Type: text/plain' );
    print "OK";
    exit();
}

$demo = new phttapi();
$opt  = array_key_exists( 'main_menu_option', $_REQUEST ) ? $_REQUEST['main_menu_option'] : '';

$demo->start_variables();
$demo->add_variable( 'IVR_variable_01', 'VariableValue01' );
$demo->end_variables();
$demo->start_params();
$demo->add_param( 'IVR_param_01', 'ParamValue01' );
$demo->end_params();

if ( preg_match( '/^10[01][0-9]$/', $opt ) ) {
    $xfer = new phttapi_dial( $opt );
    $xfer->context( 'default' );
    $xfer->dialplan( 'XML' );
    $demo->add_action( $xfer );
} else {
    switch ( $opt ) {
        case '1':
            $conf = new phttapi_dial( '9888' );
            $conf->caller_id_name( 'another book reader' );
            $conf->context( 'default' );
            $conf->dialplan( 'XML' );
            $demo->add_action( $conf );
            break;

        case '2':
            $echo = new phttapi_dial( '9196' );
            $echo->context( 'default' );
            $echo->dialplan( 'XML' );
            $demo->add_action( $echo );
            break;

        case '3':
            $moh = new phttapi_dial( '9664' );
            $moh->context( 'default' );
            $moh->dialplan( 'XML' );
            $demo->add_action( $moh );
            break;

        case '4':
            $clue = new phttapi_dial( '9191' );
            $clue->caller_id_name( 'another book reader' );
            $clue->context( 'default' );
            $clue->dialplan( 'XML' );
            $demo->add_action( $clue );
            break;

        case '5':            
            $monkey = new phttapi_dial( '1234*256' );
            $monkey->dialplan( 'enum' );
            $demo->add_action( $monkey );
            break;

        case '6':
            if ( array_key_exists( 'sub_menu_option', $_REQUEST ) && $_REQUEST['sub_menu_option'] == '*' ) {
                unset( $_SESSION['first_sub_play_done'] );
                $demo->add_action( $c = new phttapi_continue() );
                break;
            }
            $demo->start_variables();
            $demo->add_variable( 'main_menu_option', 6 );
            $demo->end_variables();

            $sub = new phttapi_playback();
            $sub->error_file( 'ivr/ivr-that_was_an_invalid_entry.wav' );
            $sub->loops( 3 );
            $sub->digit_timeout( '15000' );

            if ( !array_key_exists( 'first_sub_play_done', $_SESSION ) ) {
                $_SESSION['first_sub_play_done'] = TRUE;
                $sub->file( 'phrase:demo_ivr_sub_menu' );
            } else {
                $sub->file( 'phrase:demo_ivr_sub_menu_short' );
            }

            $star = new phttapi_action_binding( '*' );
            $sub->add_binding( $star );
            $sub->name( 'sub_menu_option' );

            $demo->add_action( $sub );
            break;

        case '9':
            $continue = new phttapi_continue();
            $demo->add_action( $continue );
            break;

        default:
            $intro = new phttapi_playback();
            $intro->error_file( 'ivr/ivr-that_was_an_invalid_entry.wav' );
            $intro->loops( 3 );
            $intro->digit_timeout( '2000' );
            $intro->input_timeout( '10000' );
            $intro->name( 'main_menu_option' );

            if ( !array_key_exists( 'first_play_done', $_SESSION ) ) {
                $_SESSION['first_play_done'] = TRUE;
                $intro->file( 'phrase:demo_ivr_main_menu' );
            } else {
                $intro->file( 'phrase:demo_ivr_main_menu_short' );
            }

            $b1   = new phttapi_action_binding( 1 );
            $b2   = new phttapi_action_binding( 2 );            
            $b3   = new phttapi_action_binding( 3 );
            $b4   = new phttapi_action_binding( 4 );
            $b5   = new phttapi_action_binding( 5 );
            $b6   = new phttapi_action_binding( 6 );
            $b9   = new phttapi_action_binding( 9 );
            $bext = new phttapi_action_binding( '~10[01][0-9]' );
            $bext->strip( '#' );


            $intro->add_binding( $bext );

            $intro->add_binding( $b1 );
            $intro->add_binding( $b2 );
            $intro->add_binding( $b3 );
            $intro->add_binding( $b4 );
            $intro->add_binding( $b5 );
            $intro->add_binding( $b6 );
            $intro->add_binding( $b9 );

            $demo->add_action( $intro );
    }
}
header( 'Content-Type: text/xml' );
foreach ( $_REQUEST as $key => $val ) {
    $demo->comment( " $key => $val " );
}

print $demo->output();
                                                                  
