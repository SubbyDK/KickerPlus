-- Some locals.
local AddonName = "KickerPlus"                      -- Just to easy get the name of the addon.
local LogInTime = GetTime()                     -- The time we login so we can make a welcome message a few sec later.
local L = {}                                    -- Create the table used for localization.
local InterruptChannel = "SAY"                  -- What channel to announce it. ("SAY", "WHISPER", "EMOTE", "PARTY", "YELL", "RAID")

-- Create frame.
local f = CreateFrame("Frame")
-- Register the event we need.
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE") -- Register the damage you do your self.
--f:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
--f:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
--f:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")

-- ====================================================================================================
-- =                                          Saved settings                                          =
-- ====================================================================================================

local AnnounceChannel
local AnnounceSolo
local AnnounceParty
local AnnounceRaid

local function LoadSettings()

    -- Make sure that we set the saved settings first time we run it, just to make sure we don't get a nil value.
    if (ANNOUNCE_CHANNEL == nil) then
        ANNOUNCE_CHANNEL = "SAY";
        ANNOUNCE_SOLO = "OFF";
        ANNOUNCE_PARTY = "ON";
        ANNOUNCE_RAID = "ON";
    end

    AnnounceChannel = ANNOUNCE_CHANNEL or "SAY"; -- SAY, YELL, PARTY or RAID
    AnnounceSolo = ANNOUNCE_SOLO or "OFF"; -- Announce when solo.
    AnnounceParty = ANNOUNCE_PARTY or "ON"; -- Announce in party.
    AnnounceRaid = ANNOUNCE_RAID or "ON"; -- Announce in raid.

    -- Create the interface after we have gotten the saved variables.
    CreateKickerPlusInterface()

end
-- ====================================================================================================
-- =                                           Localization                                           =
-- ====================================================================================================

-- =========================== English (Great Britain) or English (America) ===========================
if (GetLocale() == "enGB") or (GetLocale() == "enUS") then
    L = {
        -- The name and version of the addon.
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),

        -- Spell names. (Have to be 100% correct)
        ["KICK_NAME"] = "Kick",
        ["PUMMEL_NAME"] = "Pummel",
        ["SHIELD_BASH_NAME"] = "Shield Bash",
        ["EARTH_SHOCK_NAME"] = "Earth Shock",

        -- Other stuff.
        ["WHAT_ANNOUNCE_CHANNEL"] = "What channel do you want to announce in ?",
        ["WHEN_TO_ANNOUNCE"] = "When do you want to announce ?",

        -- Action of spell.
        ["INTERRUPT_USED"] = "INTERRUPT USED",
        ["INTERRUPT_WAS_PARRIED"] = "INTERRUPT WAS PARRIED - PLEASE INTERRUPT !",
        ["INTERRUPT_WAS_BLOCKED"] = "INTERRUPT WAS BLOCKED - PLEASE INTERRUPT !",
        ["INTERRUPT_WAS_DODGED"] = "INTERRUPT WAS DODGED - PLEASE INTERRUPT !",
        ["INTERRUPT_MISSED"] = "INTERRUPT MISSED - PLEASE INTERRUPT !",

        -- Rogue: Kick (From combat log)
        ["YOUR_KICK_HITS"] = "Your Kick hits",
        ["YOUR_KICK_CRITS"] = "Your Kick crits",
        ["YOUR_KICK_IS_PARRIED_BY"] = "Your Kick is parried by",
        ["YOUR_KICK_WAS_BLOCKED_BY"] = "Your Kick was blocked by",
        ["YOUR_KICK_WAS_DODGED_BY"] = "Your Kick was dodged by",
        ["YOUR_KICK_MISSED"] = "Your Kick missed",

        -- Warrior: Pummel (From combat log)
        ["YOUR_PUMMEL_HITS"] = "Your Pummel hits",
        ["YOUR_PUMMEL_CRITS"] = "Your Pummel crits",
        ["YOUR_PUMMEL_IS_PARRIED_BY"] = "Your Pummel is parried by",
        ["YOUR_PUMMEL_WAS_BLOCKED_BY"] = "Your Pummel was blocked by",
        ["YOUR_PUMMEL_WAS_DODGED_BY"] = "Your Pummel was dodged by",
        ["YOUR_PUMMEL_MISSED"] = "Your Pummel missed",

        -- Warrior: Shield Bash (From combat log)
        ["YOUR_SHIELD_BASH_HITS"] = "Your Shield Bash hits",
        ["YOUR_SHIELD_BASH_CRITS"] = "Your Shield Bash crits",
        ["YOUR_SHIELD_BASH_IS_PARRIED_BY"] = "Your Shield Bash is parried by",
        ["YOUR_SHIELD_BASH_WAS_BLOCKED_BY"] = "Your Shield Bash was blocked by",
        ["YOUR_SHIELD_BASH_WAS_DODGED_BY"] = "Your Shield Bash was dodged by",
        ["YOUR_SHIELD_BASH_MISSED"] = "Your Shield Bash missed",

        -- Shaman: Earth Shock (From combat log)
        ["YOUR_EARTH_SHOCK_HITS"] = "Your Earth Shock hits",
        ["YOUR_EARTH_SHOCK_CRITS"] = "Your Earth Shock crits",

        -- Mage: Counterspell (From combat log)

        -- Priest: Silence (From combat log)

        -- Warlock: Spell Lock (From combat log)

    }

-- ========================================= German (Germany) =========================================
elseif (GetLocale() == "deDE") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ========================================== French (France) =========================================
elseif (GetLocale() == "frFR") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ========================================== Italian (Italy) =========================================
elseif (GetLocale() == "itIT") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ========================================= Russian (Russia) =========================================
elseif (GetLocale() == "ruRU") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ========================================== Spanish (Spain) =========================================
elseif (GetLocale() == "esES") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ========================================= Spanish (Mexico) =========================================
elseif (GetLocale() == "esMX") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ======================================== Portuguese (Brazil) =======================================
elseif (GetLocale() == "ptBR") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ================ Chinese (Taiwan) (traditional) implemented LTR left-to-right in WoW ===============
elseif (GetLocale() == "zhTW") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ================= Chinese (China) (simplified) implemented LTR left-to-right in WoW ================
elseif (GetLocale() == "zhCN") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }

-- ================================ Korean (Korea) RTL - right-to-left ================================
elseif (GetLocale() == "koKR") then
    L = {
        ["TITLE"] = GetAddOnMetadata(AddonName, "Title") .. " ver: " .. GetAddOnMetadata(AddonName, "Version"),
    }
end

-- ====================================================================================================
-- =                                          Event handler.                                          =
-- ====================================================================================================

f:SetScript("OnEvent", function()
-- ====================================================================================================
    if (event == "ADDON_LOADED") and (arg1 == AddonName) then
        -- Load settings.
        LoadSettings()
        f:UnregisterEvent("ADDON_LOADED");
-- ====================================================================================================
    elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
        -- Did we get a message ?
        if (arg1) then
            -- Send it on to check it.
            AnnounceInterrupt(arg1)
        end
    end
end)

-- ====================================================================================================
-- =                                     OnUpdate on every frame.                                     =
-- ====================================================================================================

f:SetScript("OnUpdate", function()

    if (LogInTime ~= "Done") then
        if ((LogInTime + 3) < GetTime()) then
            DEFAULT_CHAT_FRAME:AddMessage("|cff3333ff" .. L["TITLE"] .. "|r" .. " by " .. "|cFF06c51b" .. "Subby" .. "|r" .. "|cff3333ff" .. " is loaded." .. "|r");
            LogInTime = "Done"
        end
    end

end)

-- ====================================================================================================
-- =                              Check if we are solo, in party or raid                              =
-- ====================================================================================================

local function GetGroupType()
    -- Check for a raid first, as a raid member is technically also in a party subgroup
    if GetNumRaidMembers() > 0 then
        return "RAID";
    -- If not in a raid, check for a standard 5-man party
    elseif GetNumPartyMembers() > 0 then
        return "PARTY";
    -- If not in a raid or party, you are solo
    else
        return "SOLO";
    end
end

-- ====================================================================================================
-- =                                      Announce the interrupt                                      =
-- ====================================================================================================

function AnnounceInterrupt(msg)

    -- Locals
    local Message = msg
    local MessageToSend = nil

    -- Rouge Kick
    if (string.find(Message, L["YOUR_KICK_HITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_KICK_CRITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_KICK_IS_PARRIED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_PARRIED"]
    elseif (string.find(Message, L["YOUR_KICK_WAS_BLOCKED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_BLOCKED"]
    elseif (string.find(Message, L["YOUR_KICK_WAS_DODGED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_DODGED"]
    elseif (string.find(Message, L["YOUR_KICK_MISSED"])) then
        MessageToSend = L["INTERRUPT_MISSED"]

    -- Warrior Pummel
    elseif (string.find(Message, L["YOUR_PUMMEL_HITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_PUMMEL_CRITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_PUMMEL_IS_PARRIED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_PARRIED"]
    elseif (string.find(Message, L["YOUR_PUMMEL_WAS_BLOCKED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_BLOCKED"]
    elseif (string.find(Message, L["YOUR_PUMMEL_WAS_DODGED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_DODGED"]
    elseif (string.find(Message, L["YOUR_PUMMEL_MISSED"])) then
        MessageToSend = L["INTERRUPT_MISSED"]

    -- Warrior Shield Bash
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_HITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_CRITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_IS_PARRIED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_PARRIED"]
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_WAS_BLOCKED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_BLOCKED"]
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_WAS_DODGED_BY"])) then
        MessageToSend = L["INTERRUPT_WAS_DODGED"]
    elseif (string.find(Message, L["YOUR_SHIELD_BASH_MISSED"])) then
        MessageToSend = L["INTERRUPT_MISSED"]

    -- Shaman Earth Shock
    elseif (string.find(Message, L["YOUR_EARTH_SHOCK_HITS"])) then
        MessageToSend = L["INTERRUPT_USED"]
    elseif (string.find(Message, L["YOUR_EARTH_SHOCK_CRITS"])) then
        MessageToSend = L["INTERRUPT_USED"]

    -- If it's a variation we don't know, then we tell people so they can inform about it.
    elseif (string.find(Message, "Your Kick")) or (string.find(Message, "Your Pummel")) or (string.find(Message, "Your Shield Bash")) or (string.find(Message, "Your Earth Shock")) then
        DEFAULT_CHAT_FRAME:AddMessage(AddonName .. ": New variation found.");
        DEFAULT_CHAT_FRAME:AddMessage(Message);
        DEFAULT_CHAT_FRAME:AddMessage(AddonName .. ": Please report the above to Subber on Nordanaar. (Turtle WoW)");
    end

    -- Did we get a message to send ?
    if (MessageToSend) then
        -- Do we send in raid and are we in raid ?
        if ((AnnounceRaid == "ON") and (GetGroupType() == "RAID")) then
            SendChatMessage(">> " .. MessageToSend .. " <<", AnnounceChannel, nil)
        -- Do we send in party and are we in party ?
        elseif ((AnnounceParty == "ON") and (GetGroupType() == "PARTY")) then
            -- Check that we don't try to send in RAID channel when not in raid.
            if (AnnounceChannel ~= "RAID") then
                SendChatMessage(">> " .. MessageToSend .. " <<", AnnounceChannel, nil)
            -- We can not talk in raid when not in raid group.
            else
                DEFAULT_CHAT_FRAME:AddMessage(AddonName .. ": You can not announce in " .. AnnounceChannel .. " when your not in raid.");
            end
        -- Do we send solo and are we solo ?
        elseif ((AnnounceSolo == "ON") and (GetGroupType() == "SOLO")) then
            if (AnnounceChannel ~= "RAID") and (AnnounceChannel ~= "PARTY") then
                SendChatMessage(">> " .. MessageToSend .. " <<", AnnounceChannel, nil)
            -- We can not talk in raid when not in raid group.
            elseif (AnnounceChannel == "RAID") then
                DEFAULT_CHAT_FRAME:AddMessage(AddonName .. ": You can not announce in " .. AnnounceChannel .. " when your not in raid.");
            -- We can not talk in party when not in party group.
            elseif (AnnounceChannel == "PARTY") then
                DEFAULT_CHAT_FRAME:AddMessage(AddonName .. ": You can not announce in " .. AnnounceChannel .. " when your not in party.");
            end
        end
    end

end

-- ====================================================================================================
-- ====================================================================================================
-- =                                            Interface.                                            =
-- ====================================================================================================
-- ====================================================================================================
function CreateKickerPlusInterface()

    -- Create the main frame
    frame = CreateFrame("Frame", "KickerPlus", UIParent);
        frame:SetWidth(400);
        frame:SetHeight(250);
        frame:SetPoint("CENTER", 0, 0);
        frame:SetFrameStrata("DIALOG");
        frame:SetClampedToScreen(true);
        frame:SetMovable(true);
        frame:EnableMouse(true);
        frame:RegisterForDrag("LeftButton");
        frame:SetScript("OnDragStart", function()
            this:StartMoving();
        end);
        frame:SetScript("OnDragStop", function()
            this:StopMovingOrSizing();
        end);
        frame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = {
                left = 4,
                right = 4,
                top = 4,
                bottom = 4
            }
        });
        frame:SetBackdropColor(0, 0, 0, 0.9);
        frame:Hide()

-- ====================================================================================================

    -- Close button.
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton");
        closeButton:SetWidth(32);
        closeButton:SetHeight(32);
        closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 0);
        closeButton:SetScript("OnClick", function()
            frame:Hide();
        end);
        closeButton:Show();

-- ====================================================================================================

    -- Headline
    local HeadLine = KickerPlus:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        HeadLine:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE");
        HeadLine:SetPoint("TOP", KickerPlus, "TOP", 0, -10);
        HeadLine:SetJustifyH("CENTER");
        HeadLine:SetText("Kicker Plus");

-- ====================================================================================================

    -- Text for what channel to announce in.
    local AnnounceHeadLine = KickerPlus:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        AnnounceHeadLine:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
        AnnounceHeadLine:SetPoint("TOP", KickerPlus, "TOP", 0, -60);
        AnnounceHeadLine:SetJustifyH("CENTER");
        AnnounceHeadLine:SetText(L["WHAT_ANNOUNCE_CHANNEL"]);

-- ====================================================================================================

    -- Create all the check button, we do the settings later.
    -- For channel "SAY".
    local SayCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");
    -- For channel "YELL".
    local YellCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");
    -- For channel "PARTY".
    local PartyCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");
    -- For channel "RAID".
    local RaidCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");

-- ====================================================================================================

        -- Settings for "SAY" check button.
        SayCheckButton:SetWidth(26);
        SayCheckButton:SetHeight(26);
        SayCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 60, -75);
        -- 
        if (AnnounceChannel == "SAY") then
            SayCheckButton:SetChecked(1);
        else
            SayCheckButton:SetChecked(0);
        end

        SayCheckButton:SetScript("OnClick", function()
            if (SayCheckButton:GetChecked()) then
                ANNOUNCE_CHANNEL = "SAY"
                AnnounceChannel = "SAY"
                SayCheckButton:SetChecked(1);
                YellCheckButton:SetChecked(0);
                PartyCheckButton:SetChecked(0);
                RaidCheckButton:SetChecked(0);
            else
                SayCheckButton:SetChecked(1);
            end
        end)

-- ====================================================================================================

    -- Set text for the "SAY" button.
    local SayCheckButtonText = SayCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        SayCheckButtonText:SetPoint("LEFT", SayCheckButton, "RIGHT", 0, 0);
        SayCheckButtonText:SetText("Say.");
        SayCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

        -- Settings for "YELL" check button.
        YellCheckButton:SetWidth(26);
        YellCheckButton:SetHeight(26);
        YellCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 140, -75);
        -- 
        if (AnnounceChannel == "YELL") then
            YellCheckButton:SetChecked(1);
        else
            YellCheckButton:SetChecked(0);
        end

        YellCheckButton:SetScript("OnClick", function()
            if (YellCheckButton:GetChecked()) then
                ANNOUNCE_CHANNEL = "YELL"
                AnnounceChannel = "YELL"
                SayCheckButton:SetChecked(0);
                YellCheckButton:SetChecked(1);
                PartyCheckButton:SetChecked(0);
                RaidCheckButton:SetChecked(0);
            else
                YellCheckButton:SetChecked(1);
            end
        end)

-- ====================================================================================================

    -- Set text for the "YELL" button.
    local YellCheckButtonText = YellCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        YellCheckButtonText:SetPoint("LEFT", YellCheckButton, "RIGHT", 0, 0);
        YellCheckButtonText:SetText("Yell.");
        YellCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

        -- Settings for "PARTY" check button.
        PartyCheckButton:SetWidth(26);
        PartyCheckButton:SetHeight(26);
        PartyCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 220, -75);
        -- 
        if (AnnounceChannel == "PARTY") then
            PartyCheckButton:SetChecked(1);
        else
            PartyCheckButton:SetChecked(0);
        end

        PartyCheckButton:SetScript("OnClick", function()
            if (PartyCheckButton:GetChecked()) then
                ANNOUNCE_CHANNEL = "PARTY"
                AnnounceChannel = "PARTY"
                SayCheckButton:SetChecked(0);
                YellCheckButton:SetChecked(0);
                PartyCheckButton:SetChecked(1);
                RaidCheckButton:SetChecked(0);
            else
                PartyCheckButton:SetChecked(1);
            end
        end)

-- ====================================================================================================

    -- Set text for the "PARTY" button.
    local PartyCheckButtonText = PartyCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        PartyCheckButtonText:SetPoint("LEFT", PartyCheckButton, "RIGHT", 0, 0);
        PartyCheckButtonText:SetText("Party.");
        PartyCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

        -- Settings for "RAID" check button.
        RaidCheckButton:SetWidth(26);
        RaidCheckButton:SetHeight(26);
        RaidCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 300, -75);
        -- 
        if (AnnounceChannel == "RAID") then
            RaidCheckButton:SetChecked(1);
        else
            RaidCheckButton:SetChecked(0);
        end

        RaidCheckButton:SetScript("OnClick", function()
            if (RaidCheckButton:GetChecked()) then
                ANNOUNCE_CHANNEL = "RAID"
                AnnounceChannel = "RAID"
                SayCheckButton:SetChecked(0);
                YellCheckButton:SetChecked(0);
                PartyCheckButton:SetChecked(0);
                RaidCheckButton:SetChecked(1);
            else
                RaidCheckButton:SetChecked(1);
            end
        end)

-- ====================================================================================================

    -- Set text for the "RAID" button.
    local PartyCheckButtonText = RaidCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        PartyCheckButtonText:SetPoint("LEFT", RaidCheckButton, "RIGHT", 0, 0);
        PartyCheckButtonText:SetText("Raid.");
        PartyCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

    -- Text for when you want to announce.
    local AnnounceWhenHeadLine = KickerPlus:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        AnnounceWhenHeadLine:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE");
        AnnounceWhenHeadLine:SetPoint("TOP", KickerPlus, "TOP", 0, -140);
        AnnounceWhenHeadLine:SetJustifyH("CENTER");
        AnnounceWhenHeadLine:SetText(L["WHEN_TO_ANNOUNCE"]);

-- ====================================================================================================

    -- Create all the check button, we do the settings later.
    -- For solo.
    local WhenSoloCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");
    -- For party.
    local WhenPartyCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");
    -- For raid.
    local WhenRaidCheckButton = CreateFrame("CheckButton", nil, KickerPlus, "UICheckButtonTemplate");


-- ====================================================================================================

        -- Settings for "When solo" check button.
        WhenSoloCheckButton:SetWidth(26);
        WhenSoloCheckButton:SetHeight(26);
        WhenSoloCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 50, -155);
        -- 
        if (AnnounceSolo == "ON") then
            WhenSoloCheckButton:SetChecked(1);
        else
            WhenSoloCheckButton:SetChecked(0);
        end

        WhenSoloCheckButton:SetScript("OnClick", function()
            if (WhenSoloCheckButton:GetChecked()) then
                ANNOUNCE_SOLO = "ON"
                AnnounceSolo = "ON"
                WhenSoloCheckButton:SetChecked(1);
            else
                ANNOUNCE_SOLO = "OFF"
                AnnounceSolo = "OFF"
                WhenSoloCheckButton:SetChecked(0);
            end
        end)

-- ====================================================================================================

    -- Set text for the "When solo" button.
    local WhenSoloCheckButtonText = WhenSoloCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        WhenSoloCheckButtonText:SetPoint("LEFT", WhenSoloCheckButton, "RIGHT", 0, 0);
        WhenSoloCheckButtonText:SetText("When Solo.");
        WhenSoloCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

        -- Settings for "When in party" check button.
        WhenPartyCheckButton:SetWidth(26);
        WhenPartyCheckButton:SetHeight(26);
        WhenPartyCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 150, -155);
        -- 
        if (AnnounceParty == "ON") then
            WhenPartyCheckButton:SetChecked(1);
        else
            WhenPartyCheckButton:SetChecked(0);
        end

        WhenPartyCheckButton:SetScript("OnClick", function()
            if (WhenPartyCheckButton:GetChecked()) then
                ANNOUNCE_PARTY = "ON"
                AnnounceParty = "ON"
                WhenPartyCheckButton:SetChecked(1);
            else
                ANNOUNCE_PARTY = "OFF"
                AnnounceParty = "OFF"
                WhenPartyCheckButton:SetChecked(0);
                if (AnnounceChannel == "PARTY") then
                    PartyCheckButton:SetChecked(0);
                    SayCheckButton:SetChecked(1);
                    ANNOUNCE_CHANNEL = "SAY";
                    AnnounceChannel = "SAY";
                end
            end
        end)

-- ====================================================================================================

    -- Set text for the "When in party" button.
    local WhenPartyCheckButtonText = WhenPartyCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        WhenPartyCheckButtonText:SetPoint("LEFT", WhenPartyCheckButton, "RIGHT", 0, 0);
        WhenPartyCheckButtonText:SetText("In Party.");
        WhenPartyCheckButtonText:SetJustifyH("LEFT");

-- ====================================================================================================

        -- Settings for "When in raid" check button.
        WhenRaidCheckButton:SetWidth(26);
        WhenRaidCheckButton:SetHeight(26);
        WhenRaidCheckButton:SetPoint("TOPLEFT", "KickerPlus", "TOPLEFT", 250, -155);
        -- 
        if (AnnounceRaid == "ON") then
            WhenRaidCheckButton:SetChecked(1);
        else
            WhenRaidCheckButton:SetChecked(0);
        end

        WhenRaidCheckButton:SetScript("OnClick", function()
            if (WhenRaidCheckButton:GetChecked()) then
                ANNOUNCE_RAID = "ON"
                AnnounceRaid = "ON"
                WhenRaidCheckButton:SetChecked(1);
            else
                ANNOUNCE_RAID = "OFF"
                AnnounceRaid = "OFF"
                WhenRaidCheckButton:SetChecked(0);
                if (AnnounceChannel == "RAID") then
                    RaidCheckButton:SetChecked(0);
                    SayCheckButton:SetChecked(1);
                    ANNOUNCE_CHANNEL = "SAY";
                    AnnounceChannel = "SAY";
                end
            end
        end)

-- ====================================================================================================

    -- Set text for the "When in raid" button.
    local WhenRaidCheckButtonText = WhenRaidCheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        WhenRaidCheckButtonText:SetPoint("LEFT", WhenRaidCheckButton, "RIGHT", 0, 0);
        WhenRaidCheckButtonText:SetText("In Raid.");
        WhenRaidCheckButtonText:SetJustifyH("LEFT");

end

-- ====================================================================================================
-- =                                          Slash commands                                          =
-- ====================================================================================================

SLASH_KICKER_PLUS1, SLASH_KICKER_PLUS2 = '/kp', '/kickerplus'
function SlashCmdList.KICKER_PLUS()
    frame:Show()
end



























