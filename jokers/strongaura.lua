SMODS.Joker {
    key = 'strong_aura',
    config = {},
    loc_txt = {
        name = 'Strong Aura',
        text = {
            "Cards held in hand",
            "trigger their {C:dark_edition}Edition{}"
        }
    },
    pos = {
        x = 2,
        y = 1
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
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.edition then
                local c = context.other_card.edition.chips or (context.other_card.edition.foil and 50) or 0
                local m = context.other_card.edition.mult or (context.other_card.edition.holo and 10) or 0
                local xm = context.other_card.edition.x_mult or (context.other_card.edition.polychrome and 1.5) or 1
                
                local ret = {}
                local has_edition = false
                
                if c > 0 then 
                    ret.chips = c
                    has_edition = true
                end
                if m > 0 then 
                    ret.mult = m
                    has_edition = true
                end
                if xm > 1 then 
                    ret.xmult = xm
                    has_edition = true
                end
                
                if has_edition then
                    SMODS.calculate_effect(ret, context.other_card, true)
                    return { effect = true, no_juice = true }
                end
            end
        end
    end
}