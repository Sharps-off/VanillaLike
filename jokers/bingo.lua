
SMODS.Joker{
    key = "bingo",
    config = {
        extra = {
            Mult = 5
        }
    },
    loc_txt = {
        ['name'] = 'Bingo',
        ['text'] = {
            [1] = 'Played {C:attention}#2#{} cards give',
            [2] = '{C:red}+#1# Mult{} when scored',
            [3] = '{s:0.9,C:default}rank changes at end of round{}'
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
    pools = { ["vl_vl_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.Mult, localize((G.GAME.current_round.Rank1_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.Rank1_card = { rank = '10', id = 10 }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    mult = card.ability.extra.Mult
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.playing_cards then
                local valid_Rank1_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_Rank1_cards[#valid_Rank1_cards + 1] = v
                    end
                end
                if valid_Rank1_cards[1] then
                    local Rank1_card = pseudorandom_element(valid_Rank1_cards, pseudoseed('Rank1' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.Rank1_card.rank = Rank1_card.base.value
                    G.GAME.current_round.Rank1_card.id = Rank1_card.base.id
                end
            end
        end
    end
}