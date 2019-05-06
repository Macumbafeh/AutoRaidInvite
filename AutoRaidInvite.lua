local MyAddon = CreateFrame("frame", "MyAddonFrame")
local guildMembersCache = {}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

MyAddon:RegisterEvent("CHAT_MSG_WHISPER")
MyAddon:SetScript("OnEvent", function(self, event, msg, sender)

    --init guildMembersCache in case its not
    if (getn(guildMembersCache) ~= GetNumGuildMembers()) then
        GuildRoster();
        local guildSize = GetNumGuildMembers();
        for i = 1, guildSize do
            local guildMemberName = GetGuildRosterInfo(i);
            table.insert(guildMembersCache, guildMemberName)
        end
    end
    local isFromOwnGuild = has_value(guildMembersCache, sender)
    local magicWordChecksOut = (msg == "raid") or (msg == "inv") or (msg == "invite") or (msg == "+")

    if isFromOwnGuild and magicWordChecksOut then
        if (GetNumPartyMembers() == 4) and (UnitInRaid("player") == nil) then
            ConvertToRaid()
        end
        InviteUnit(sender)
    end

end)