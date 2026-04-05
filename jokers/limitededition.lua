
SMODS.Joker{
    key = "limitededition",
    config = {
        extra = {
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'Limited Edition',
        ['text'] = {
            [1] = 'When a card is scored,',
            [2] = '{C:green}#1# in #2#{} chance to add {C:dark_edition}Foil{},',
            [3] = '{C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{} {C:default}edition{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vl_vl_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["e_polychrome"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_polychrome\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_1 = G.P_CENTERS["e_holo"]
        if info_queue_1 then
            info_queue[#info_queue + 1] = info_queue_1
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_holo\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_2 = G.P_CENTERS["e_foil"]
        if info_queue_2 then
            info_queue[#info_queue + 1] = info_queue_2
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"e_foil\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_modprefix_limitededition') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.before then
            for i = 1,#context.scoring_hand do

                local scoring_card = context.scoring_hand[i]

                if scoring_card.edition == nil then
                    if SMODS.pseudorandom_probability(card, 'group_0_6eb7b183', 1, card.ability.extra.odds, 'j_vl_limitededition', false) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                
                                local random_edition = pseudorandom_element({'e_foil','e_holo','e_polychrome'}, 'random edition')
                                if random_edition then
                                    scoring_card:set_edition(random_edition, true)
                                end
                                return true
                            end
                        }))
                        
                    end
                end
            end
            
        end
    end
}