
SMODS.Back {
    key = 'fragile_deck',
    pos = { x = 1, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Fragile Deck',
        text = {
            [1] = 'Every {C:attention}discarded{} card',
            [2] = 'is {C:attention}destroyed{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',

    calculate = function(self, card, context)
        if context.discard  then
            return {
                remove = true,
            }
        end
    end
}