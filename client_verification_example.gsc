init() {
    level.guid_list   = [ "<guid_1>", "<guid_2>", "<guid_3>" ];
    level.guid_verify = level.rankedmatch;
    level.auto_verify = false;

    if( !level.guid_verify )
        level.debug_leave = true;

    level thread on_ended();
    level thread on_connect();
}

on_connect() {
    level endon( "game_ended" );
    for( ;; ) {
        level waittill( "connected", player );
        if( isbot( player ) || istestclient( player ) )
            continue;

        player.verification = level.guid_verify ? ( player is_admin() ? "Admin" : ( level.auto_verify ? "Access" : undefined ) ) : ( player ishost() ? "Host" : ( level.auto_verify ? "Access" : undefined ) );
        if( !isdefined( player.verification ) )
            continue;

        player thread on_event();
    }
}

on_event() {
    self endon( "disconnect" );
    for( ;; ) {
        event_name = self common_scripts\utility::waittill_any_return( "spawned_player", "death" );
        switch( event_name ) {
            case "spawned_player":
                self iprintln( "Status: " + self.verification );
                self iprintln( level.guid_verify ? "Is Server" : "Is Private Match" );
                break;
            default:
                break;
        }
    }
}

on_ended() {
    level waittill( "game_ended" );
    level endon( "game_ended" );
    if( level.debug_leave )
        exitlevel( false );
}

is_admin() {
    if( !isdefined( level.guid_list ) || !level.guid_list.size )
        return false;
    
    for( i = 0; i < level.guid_list.size; i++ )
        if( level.guid_list[ i ] == self.guid )
            return true;

    return false;
}