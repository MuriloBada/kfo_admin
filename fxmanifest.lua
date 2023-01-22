fx_version 'adamant'
games {'rdr3'}
author 'Murilo Bada a.k.a KIFOO <murilomaffiolettibada@hotmail.com>'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'client/client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@kfo_logSender/server/sv_main.lua',
    '@kfo_logSender/Config.lua',
    '@kfo_permissions/server/server.lua',
    'server/server.lua',
}