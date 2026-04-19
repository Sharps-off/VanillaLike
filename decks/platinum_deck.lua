
SMODS.Back {
    key = 'platinum_deck',
    pos = { x = 8, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Platinum Deck',
        text = {
            '{C:attention}Vouchers{} are combined',
            'with their {C:attention}upgraded{}',
            'versions and cost {C:gold}$20{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    calculate = function(self, back, context)
        if context.modify_shop_card then
            if context.card.ability.set == 'Voucher' then
                context.card.base_cost = 20
                context.card:set_cost()
            end
        end

        if context.buying_card then
            if context.card.ability.set == 'Voucher' then
                local upgraded_voucher = nil
                
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Voucher' and v.requires then
                        for _, req in ipairs(v.requires) do
                            if req == context.card.config.center.key then
                                upgraded_voucher = k
                                break
                            end
                        end
                    end
                end

                if upgraded_voucher and not G.GAME.used_vouchers[upgraded_voucher] then
                    local v_card = SMODS.create_card({
                        set = 'Voucher',
                        area = G.vouchers,
                        key = upgraded_voucher
                    })
                    v_card:add_to_deck()
                    G.vouchers:emplace(v_card)
                    v_card:redeem()
                end
            end
        end
    end 
}