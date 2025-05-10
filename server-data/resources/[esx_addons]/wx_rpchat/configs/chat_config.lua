wx = {}

wx.Logs = false -- Enable logging for messages. Make sure to configure webhooks in configs/webhook_config.lua

wx.MaxHereTexts = 5 -- How many /here texts can one player place?
wx.MaxDocCount = 60 -- Maximum /doc time player can do
wx.MeDoDisplayTime = 5000 -- [in ms] How long should /me and /do 3D texts be displayed
wx.OnlyInicials = true -- In commands like /me, /do, use only char name inicials. (John Doe -> J. D.)
wx.Reports = false -- Enable reports? /report
wx.AdminChat = true -- Enable admin chat? /a
wx.TransparentStatusHere = false -- Enable transparent background for /here and /status texts
wx.AdCost = 1000 -- Price for sending advertisements, money will be checked and removed from bank
wx.AdCooldown = 15000 -- in ms, how long should the cooldown between sending ads should be
wx.LOOCAdminPrefixes = true -- Enable admin prefixes for LOOC messages. (If admin has group admin, the mssage will be - [ADMIN] PlayerName: Message )

wx.Commands = {
-- Don't Touch             /command name
    ["Status"]              = "status",
    ["Here"]                = "here",
    ["Advertisement"]       = "ad",
    ["EMS"]                 = "ems",
    ["Police"]              = "police",
    ["Sheriff"]             = "sheriff",
    ["Blackmarket"]         = "bm",
    ["Twitter"]             = "tweet",
    ["Staff Announcement"]  = "staff",
    ["Job"]                 = "job",
}

wx.Suggestions = { -- /command suggestions that will pop up in chat (Make sure to add /)
    ['/me'] = {
        description = "/me command",
        argument = { ["MESSAGE"] = "[TEXT]" }
    },
    ['/do'] = {
        description = "/do command",
        argument = { ["MESSAGE"] = "[TEXT]" }
    },
    [wx.Commands["Advertisement"]] = {
        description = "Share an advertisement for all players, costs "..wx.AdCost.."$",
        argument = { ["MESSAGE"] = "[TEXT]" }
    },
    ['/report'] = {
        description = "Command using to communicate with admins",
        argument = { ["REPORT CONTENT"] = "What do you want to report?" }
    },
    ['/dm'] = {
        description = "[ADMIN ONLY] Private message command",
        argument = { ["ID"] = "Player ID" }
    },
}

wx.Jobs = {
-- Don't Touch  Job Name
    ['LSPD']  =   'police',
    ['EMS']   =   'ambulance',
    ['LSSD']  =   'sheriff',
}

wx.AdminGroups = { -- Which groups should have access to the admin commands and optionally the prefix?
-- GROUP NAME   true/false
    ["admin"]    = true,
    ["mod"]      = true,
    ["owner"]    = true,
    ["staff"]    = true,
    ["trial"]    = true,
}

wx.AutoMessages = true
wx.AutoMessageInterval = 25 -- In minutes
wx.AutoMessagesList = { -- List of messages that will be randomly sent
    "Discord ufficiale! https://discord.com/invite/ksGfNvDEfq",
}

Notify = function(title,desc) -- You can add your own notify function
    lib.notify({
        title = title,
        description = desc,
        position = 'top',
        style = {
            backgroundColor = '#1E1E2E',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'comments',
        iconColor = '#457b9d'
    })
end