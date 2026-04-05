
SMODS.Joker{
    key = "silberkonigmask",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Silberkönig Mask',
        ['text'] = {
            [1] = 'All played {C:attention}face {}cards',
            [2] = 'become {C:attention}Steel{} cards',
            [3] = 'when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
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
    pools = { ["vl_vl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
    
        local info_queue_0 = G.P_CENTERS["m_steel"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_steel\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.before then
            
            local activations = 0

            for i = 1,#context.scoring_hand do

                local card_to_check = context.scoring_hand[i]

                local is_face_card = card_to_check:is_face()

                if is_face_card then
                    activations = activations + 1
                    context.scoring_hand[i]:set_ability(G.P_CENTERS["m_steel"], nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.scoring_hand[i]:juice_up()
                            return true
                        end
                    }))

                end
            end

            if activations > 0 then
                return {
                    message = "Steel"
                }
            end
        end
    end
}