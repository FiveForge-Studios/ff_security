-- Manifest data
fx_version "adamant"
game "gta5"

-- Resource Information
description "A security system to help you monitor all criminal activity in your server."
version "v1.0.0"
author "akaLucifer#0103"
url "https://github.com/aka-lucifer/lx_security"

-- Resource Data
shared_script"shared/shared.lua"

client_scripts {
    "client/classes/*.lua",
    "client/managers/*.lua",
    "client/*.lua",
}

server_script "server/main.lua"

export "GetClosestCam"