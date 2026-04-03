
SMODS.Joker{ --Red Joker
    key = "redjoker",
    config = {
        extra = {
            cardsindeck = 1
        }
    },
    loc_txt = {
        ['name'] = 'Red Joker',
        ['text'] = {
            [1] = '{C:white,X:red}+0.03X{} Mult for each',
            [2] = 'remaining card in {C:attention}deck{}',
            [3] = '{C:inactive}(Currently {}{C:white,X:red}+#1#X{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.cardsindeck + ((#(G.deck and G.deck.cards or {}) or 0)) * 0.03}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.cardsindeck + (#(G.deck and G.deck.cards or {})) * 0.03
            }
        end
    end
}