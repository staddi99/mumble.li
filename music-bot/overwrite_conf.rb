def ext_config()
    puts "Own Config loading and overwriting default settings!"
    overwrite = {  
                    mumbleserver_host: "[SERVER_HOST]",
                    mumbleserver_port: [SERVER_PORT],
                    mumbleserver_username: "[BOT_USER_NAME]",
                    mumbleserver_targetchannel: "[BOT_USER_CHANNEL]",
                    mumbleserver_userpassword: "[BOT_USER_PASSWORD]",
                    quality_bitrate: 72000,
                    stop_on_unregistered_users: false,
                    mpd_fifopath: "[BOT_HOME]/mpd[BOT_ID]/mpd.fifo",
                    mpd_port: [MPD_PORT],
                    initial_volume: nil
                 }

    @settings = @settings.merge(overwrite)
end
