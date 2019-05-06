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

--MyAddon:SetBackdrop({
--    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
--    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
--    tile = 1, tileSize = 6, edgeSize = 6,
--    insets = { left = 3, right = 3, top = 3, bottom = 3 }
--})
--MyAddon:SetWidth(100)
--MyAddon:SetHeight(50)
--MyAddon:SetPoint("CENTER", UIParent)
--MyAddon:EnableMouse(true)
--MyAddon:SetMovable(true)
--MyAddon:RegisterForDrag("LeftButton")
--MyAddon:SetScript("OnDragStart", function(self)
--    self:StartMoving()
--end)
--MyAddon:SetScript("OnDragStop", function(self)
--    self:StopMovingOrSizing()
--end)
--MyAddon:SetFrameStrata("FULLSCREEN_DIALOG")
--
--local editBox = CreateFrame("EditBox", nil, MyAddon, "InputBoxTemplate");
--editBox:SetHeight(10)
--editBox:SetWidth(50)
--editBox:SetPoint("TOP", MyAddon, "TOP", 0, -10)
--editBox:SetFont(GameFontNormal:GetFont(), 7, "OUTLINE")
--editBox:SetText("Test")
--editBox:SetAutoFocus(false);
--
--local button = CreateFrame("button", "MyAddonButton", MyAddon, "UIPanelButtonTemplate")
--button:SetHeight(15)
--button:SetWidth(25)
--button:SetPoint("BOTTOM", MyAddon, "BOTTOM", 0, 10)
--button:SetFont(GameFontNormal:GetFont(), 7, "OUTLINE")
--button:SetText("Close")
--button:SetScript("OnClick", function(self)
--    PlaySound("igMainMenuOption")
--    self:GetParent():Hide()
--    print(editBox:GetText())
--end)