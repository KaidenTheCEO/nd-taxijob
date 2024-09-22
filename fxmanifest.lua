fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Kmatt'
description 'ND Core version of qb-taxi'
version '1.2.0'

ui_page 'html/meter.html'

shared_scripts {
    '@ND_Core/init.lua',
    '@ox_lib/init.lua',
    '@ND_Core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_script 'server/main.lua'

files {
    'html/meter.css',
    'html/meter.html',
    'html/meter.js',
    'html/reset.css',
    'html/g5-meter.png'
}
