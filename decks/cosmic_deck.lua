
SMODS.Back {
    key = 'cosmic_deck',
    pos = { x = 5, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Cosmic Deck',
        text = {
            [1] = '{C:attention}Vouchers{} are only replaced the',
            [2] = 'round after you buy one'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    
}

local visit_shop_ref = G.FUNCS.visit_shop

function G.FUNCS.visit_shop(e)

    local ret = visit_shop_ref(e)

    print(G.GAME.selected_back.effect.center.key == "b_moredecks_cosmic_deck")

    if G.GAME.selected_back.effect.center.key == "b_moredecks_cosmic_deck" then
        
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.shop_vouchers and #G.shop_vouchers.cards == 0 then

                    local new_voucher = SMODS.create_card({
                        set = 'Voucher',
                        area = G.shop_vouchers,
                        key_append = 'cosmic_restock'
                    })
                    
                    G.shop_vouchers:emplace(new_voucher)
                    
                end
                
                return true
            end
        }))
    end

    return ret
end