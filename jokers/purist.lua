
SMODS.Joker{
    key = "purist",
    config = {
        extra = {
            xchips0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Purist',
        ['text'] = {
            [1] = 'Non {C:enhanced}Enhanced{} cards',
            [2] = 'give {X:red,C:white}x1.5{} Mult when',
            [3] = 'scored'
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
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vanillal_vanillal_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            return {
                x_chips = 1.5
            }
        end
    end
}