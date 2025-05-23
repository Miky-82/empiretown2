fx_version("adamant")

game("gta5")

author("bitpredator")
description("Allows Players to use LS Customs to customise their cars")
lua54("yes")
version("1.0.9")

shared_script({
    "@es_extended/imports.lua",
})

server_scripts({
    "@oxmysql/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "locales/*.lua",
    "config.lua",
    "server/*.lua",
})

client_scripts({
    "@es_extended/locale.lua",
    "locales/*.lua",
    "config.lua",
    "client/*.lua",
})
