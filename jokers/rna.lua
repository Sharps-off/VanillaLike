
SMODS.Joker{
    key = "rna",
    config = {
        extra = {
            deck = 0
        }
    },
    loc_txt = {
        name = 'RNA',
        text = {
            'If {C:attention}first hand{} of round',
            'has only {C:attention}1{} card, add a',
            '{C:attention}random{} {C:dark_edition}Polychrome{} card',
            'in your hand'
        }
    },
    pos = {
        x = 0,
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
    pools = { ["vl_mycustom_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["e_polychrome"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_polychrome\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.before then
            if (to_big(#context.scoring_hand) == to_big(1) and G.GAME.current_round.hands_played == 0) then

                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))

                SMODS.add_card({
                    key = card_front.key,
                    set = "Base",
                    edition = "e_polychrome",
                    area = G.hand
                })

                return {
                    message = "Created",
                    colour = G.C.BLUE
                }

            end
        end

        if context.setting_blind then

            local target_card = context.other_card

            local function juice_card_until_(card, eval_func, first, delay)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
                    func = (function() if eval_func(card) then if not first or first then card:juice_up(0.1, 0.1) end; juice_card_until_(card, eval_func, nil, 0.8) end return true end)
                }))
            end

            return {
                func = function()
                    local eval = function() return not G.RESET_JIGGLES and G.GAME.current_round.hands_played == 0 end
                    juice_card_until_(card, eval, true)
                    return true
                end
            }

        end

    end

}