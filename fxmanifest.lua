fx_version 'cerulean'
game 'gta5'

description 'Standalone Weapon Shop integrated with MDT'
author 'BevanDoooooo'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    '@qb-core/client/cl_main.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
