
SMODS.Back {
    key = 'discount_deck',
    pos = { x = 5, y = 0 },
    config = {
        vouchers = { "v_clearance_sale" },
    },
    loc_txt = {
        name = 'Discount Deck',
        text = {
            [1] = 'Start run with',
            [2] = '{C:gold}Clearance Sale{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.GAME.used_vouchers['v_clearance_sale'] = true
        G.GAME.discount_percent = 25
    end
}