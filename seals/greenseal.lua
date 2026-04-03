
SMODS.Seal {
    key = 'greenseal',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            card_draw0 = 1,
            ToDraw = 3
        }
    },
    badge_colour = HEX('42a17a'),
    loc_txt = {
        name = 'Green Seal',
        label = 'Green Seal',
        text = {
            [1] = 'Draw {C:attention}1{} card when {C:attention}scored{}',
            [2] = '{C:attention}Destroy{} this card at end of',
            [3] = 'round if held in hand'
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    sound = { sound = "generic1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.seal.extra.ToDraw}}
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and card.should_destroy then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve()
                    return true
                end
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Destroyed!", colour = G.C.RED})
            return
        end
        if context.main_scoring and context.cardarea == G.play then
            if G.hand and #G.hand.cards > 0 then
                SMODS.draw_cards(1)
            end
            return {
                message = "+"..tostring(1).." Cards Drawn"
            }
        end
        if context.end_of_round and context.cardarea == G.hand and context.other_card == card and context.individual then
            card.should_destroy = true
        end
    end
}