
SMODS.Back {
    key = 'chaotic_deck',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            all_blinds_size0 = 2
        },
        randomize_rank_suit = true,
    },
    loc_txt = {
        name = 'Chaotic Deck',
        text = {
            [1] = 'All {C:attention}Ranks{}, {C:attention}Suits{} and',
            [2] = '{C:attention}Enhancements{} in deck',
            [3] = 'are randomized',
            [4] = 'Start with {C:gold}-20${}',
            [5] = '{C:red}X2{} base Blind size'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    local cen_pool = {}
                    for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if enhancement_center.key ~= 'm_stone' then
                            cen_pool[#cen_pool + 1] = enhancement_center
                        end
                    end
                    local enhancement = pseudorandom_element(cen_pool, 'random_enhance')
                    v:set_ability(enhancement)
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 2
                return true
            end
        }))
        G.GAME.starting_params.dollars = -20
    end
}