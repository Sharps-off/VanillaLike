
SMODS.Joker{
    key = "wildroulette",
    config = {
        extra = {
            repetitions0 = 1
        }
    },
    loc_txt = {
        name = 'Wild Roulette',
        text = {
            'Retrigger all played',
            '{V:1}#1#{} cards',
            '{s:0.8,C:default}suit change at end of round{}'
        },
        unlock = {
            'Unlocked by default.'
        }
    },
    pos = { 
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vl_vl_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize((G.GAME.current_round.suit_card or {}).suit or 'Spades', 'suits_singular'),
                colours = {
                    G.C.SUITS[(G.GAME.current_round.suit_card or {}).suit or 'Spades']
                }
            }
        }
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.suit_card = { suit = 'Spades' }
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:is_suit(G.GAME.current_round.suit_card.suit) then
                return {
                    repetitions = 1,
                    message = localize('k_again_ex')
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.playing_cards then
                local valid_suit_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suit_cards[#valid_suit_cards + 1] = v
                    end
                end
                if valid_suit_cards[1] then
                    local suit_card = pseudorandom_element(valid_suit_cards, pseudoseed('suit' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.suit_card.suit = suit_card.base.suit
                end
            end
        end
    end
}