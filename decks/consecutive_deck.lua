
SMODS.Back {
    key = 'consecutive_deck',
    pos = { x = 5, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Consecutive Deck',
        text = {
            '{C:attention}Vouchers{} are only replaced',
            'the round after you buy one'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    calculate = function(self, back, context)
        if context.ending_shop then
            if G.shop_vouchers and #G.shop_vouchers.cards > 0 then
                G.GAME.cosmic_saved_voucher = G.shop_vouchers.cards[1].config.center.key
            else
                G.GAME.cosmic_saved_voucher = 'empty'
            end
        end

        if context.starting_shop then
            if G.GAME.cosmic_saved_voucher and G.GAME.cosmic_saved_voucher ~= 'empty' then
                if G.shop_vouchers then
                    if #G.shop_vouchers.cards > 0 and G.shop_vouchers.cards[1].config.center.key ~= G.GAME.cosmic_saved_voucher then
                        G.shop_vouchers.cards[1]:remove()
                        SMODS.add_voucher_to_shop(G.GAME.cosmic_saved_voucher)
                    elseif #G.shop_vouchers.cards == 0 then
                        SMODS.add_voucher_to_shop(G.GAME.cosmic_saved_voucher)
                    end
                end
            elseif G.GAME.cosmic_saved_voucher == 'empty' then
                if G.shop_vouchers and #G.shop_vouchers.cards == 0 then
                    SMODS.add_voucher_to_shop()
                end
            end
        end
    end
}