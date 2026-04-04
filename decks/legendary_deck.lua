table.insert(SMODS.ObjectTypes['Joker'].rarities, { key = 'Legendary' })

SMODS.Rarity:take_ownership('Legendary', {
    get_weight = function(self, weight, object_type)
        if G.GAME and G.GAME.legendary_shop_enabled then
            return 0.02
        end
        return 0
    end
}, true)

SMODS.Back {
    key = 'legendary_deck',
    pos = { x = 2, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Legendary Deck',
        text = {
            [1] = '{C:legendary,E:1}Legendary{} {C:attention}Joker{} can',
            [2] = 'appear in the shop'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.GAME.legendary_shop_enabled = true
    end
}