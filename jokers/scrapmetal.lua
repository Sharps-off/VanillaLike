
SMODS.Joker{ --Scrap Metal
    key = "scrapmetal",
    config = {
        extra = {
            dollars0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Scrap Metal',
        ['text'] = {
            [1] = 'Earn {C:money}$2{} for every',
            [2] = '{C:attention}5{} cards discarded',
            [3] = 'at the same time'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vanillal_vanillal_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.pre_discard  then
            if to_big(#context.full_hand) >= to_big(5) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + 2
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(2), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
    end
}