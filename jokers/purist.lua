
SMODS.Joker{
    key = "purist",
    config = { extra = { x_mult = 1.5 } },
    loc_txt = {
        name = 'Purist',
        text = {
            'Non {C:enhanced}Enhanced{} cards',
            'give {X:red,C:white}x1.5{} Mult when',
            'scored'
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
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then
                        return false
                    end
                end
                return true
            end)() then
                return {
                    Xmult = 1.5
                }
            end
        end
    end
}