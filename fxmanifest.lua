fx_version 'cerulean'
game 'gta5'

description 'Astro Job Creator'
version '1.0'

lua54 'yes'


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'jobs/*.lua'
}

client_script {
    '@menuv/menuv.lua',
    'client/client.lua',
}


lua54 'yes'