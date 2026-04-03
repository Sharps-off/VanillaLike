
SMODS.Joker{ --Showing Off
    key = "showingoff",
    config = {
        extra = {
            repetitions0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Showing Off',
        ['text'] = {
            [1] = 'Retrigger all played',
            [2] = 'cards if hand contains',
            [3] = '{C:attention}5{} scoring {C:enhanced}Enhanced{} cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vanillal_vanillal_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            return {
                repetitions = 1,
                message = localize('k_again_ex')
            }
        end
    end
}