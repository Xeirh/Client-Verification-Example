init() {
    level.guid_list     = [ "<guid 1>", "<guid 2>", "<guid 3>" ];
    level.auto_verify   = false;
    level.private_match = !level.rankedmatch;
    if( is_true( level.private_match ) ) {
        level.debug_leave = true;
        level thread game_ended();
    }

    level onplayerconnect_callback( ::event_system );
}

event_system() {
    self endon( "disconnect" );
    while( true ) {
        event_name = self common_scripts\utility::waittill_any_return( "spawned_player", "death" );
        switch( event_name ) {
            case "spawned_player":
                // filter out bots
                if( isbot( self ) || istestclient( self ) )
                    continue;

                self.access = level.private_match ? ( self is_host() ? "Host" : ( level.auto_verify ? "Access" : undefined ) ) : ( self is_admin() ? "Admin" : ( level.auto_verify ? "Access" : undefined ) );
                
                // filter out undefined access users
                if( !isdefined( self.access ) )
                    continue;

                // bots and undefined access users will not make it down here
                self iprintln( "Access: " + self.access );
                self iprintln( level.private_match ? "Session: Is Private" : "Session: Is Public" );
                break;
            default:
                self iprintln( event_name );
                break;
        }
    }
}

game_ended() {
    level waittill( "game_ended" );
    level endon( "game_ended" );
    if( level.debug_leave )
        exitlevel( false );
}

is_host() {
    return isdefined( self ) && self == level.players[ 0 ];
}

is_admin() {
    if( !isdefined( level.guid_list ) || !isarray( level.guid_list ) || !level.guid_list.size )
        return false;

    for( i = 0; i < level.guid_list.size; i++ )
        if( self.guid == level.guid_list[ i ] )
            return true;

    return false;
}
