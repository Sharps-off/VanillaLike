
SMODS.Joker{
    key = "royalseal",
    config = {
        extra = {
            repetitions0 = 1
        }
    },
    loc_txt = {
        name = 'Royal Seal',
        text = {
            'Retrigger all scoring',
            'cards with a {C:attention}Seal{}'
        }
    },
    pos = {
        x = 6,
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
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card.seal ~= nil then
                return {
                    repetitions = 1,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}