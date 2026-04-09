
SMODS.Joker {
    key = "judgejoker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        name = 'Judge Joker',
        text = {
            'Creates a {C:attention}Joker{} when',
            '{C:attention}Blind{} is selected',
            '{C:inactive}(Must have room){}'
        }
    },
    pos = {
        x = 10,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vanillal_mycustom_jokers"] = true },
    calculate = function(self, card, context)
        if context.setting_blind then

            if #G.jokers.cards < G.jokers.config.card_limit then
                
                SMODS.add_card({
                    set = 'Joker',
                    soulable = false
                })
                
                return {
                    message = 'Created!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}
