SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomSeals", 
    path = "CustomSeals.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "jokers"
    local files = SMODS.NFS.getDirectoryItemsInfo(jokers_path)

    if files then
        for _, file in ipairs(files) do
            if file.name and file.name:sub(-4) == ".lua" then
                assert(SMODS.load_file("jokers/" .. file.name))()
            end
        end
    end
end

local function load_decks_folder()
    local mod_path = SMODS.current_mod.path
    local decks_path = mod_path .. "decks"
    local files = SMODS.NFS.getDirectoryItemsInfo(decks_path)

    if files then
        for _, file in ipairs(files) do
            if file.name and file.name:sub(-4) == ".lua" then
                assert(SMODS.load_file("decks/" .. file.name))()
            end
        end
    end
end

local function load_consumables_folder()
    local mod_path = SMODS.current_mod.path
    local consumables_path = mod_path .. "consumables"
    local files = SMODS.NFS.getDirectoryItemsInfo(consumables_path)

    if files then
        for _, file in ipairs(files) do
            if file.name == "sets.lua" then
                assert(SMODS.load_file("consumables/sets.lua"))()
                break
            end
        end    
        
        for _, file in ipairs(files) do
            if file.name and file.name:sub(-4) == ".lua" and file.name ~= "sets.lua" then
                assert(SMODS.load_file("consumables/" .. file.name))()
            end
        end
    end
end

local function load_enhancements_folder()
    local mod_path = SMODS.current_mod.path
    local enhancements_path = mod_path .. "enhancements"
    local files = SMODS.NFS.getDirectoryItemsInfo(enhancements_path)

    if files then
        for _, file in ipairs(files) do
            if file.name and file.name:sub(-4) == ".lua" then
                assert(SMODS.load_file("enhancements/" .. file.name))()
            end
        end
    end
end

local function load_seals_folder()
    local mod_path = SMODS.current_mod.path
    local seals_path = mod_path .. "seals"
    local files = SMODS.NFS.getDirectoryItemsInfo(seals_path)

    if files then
        for _, file in ipairs(files) do
            if file.name and file.name:sub(-4) == ".lua" then
                assert(SMODS.load_file("seals/" .. file.name))()
            end
        end
    end
end

load_jokers_folder()
load_decks_folder()
load_consumables_folder()
load_enhancements_folder()
load_seals_folder()
SMODS.ObjectType({
    key = "vl_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "vl_vl_jokers",
    cards = {
        ["j_vl_bingo"] = true,
        ["j_vl_limitededition"] = true,
        ["j_vl_mirroredjoker"] = true,
        ["j_vl_motley"] = true,
        ["j_vl_royalseal"] = true,
        ["j_vl_silberkonigmask"] = true,
        ["j_vl_wildjoker"] = true
    },
})

SMODS.ObjectType({
    key = "vl_mycustom_jokers",
    cards = {
        ["j_vl_rna"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end