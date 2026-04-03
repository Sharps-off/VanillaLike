
SMODS.Back {
    key = 'sniper_deck',
    pos = { x = 5, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Sniper Deck',
        text = {
            [1] = '{C:red}+3{} discards every round',
            [2] = '{C:blue}-3{} hand every round',
            [3] = 'At end of each round:',
            [4] = '{C:gold}$2{}{s:0.9} per remaining {}{C:red}Discard{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.GAME.starting_params.hands = 1
        G.GAME.starting_params.discards = 6
        G.GAME.modifiers.money_per_discard = 2
    end
}