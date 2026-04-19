
SMODS.Back {
    key = 'purple_deck',
    pos = { x = 1, y = 0 },
    config = { voucher_reroll_cost = 10 },
    loc_txt = {
        name = 'Purple Deck',
        text = {
            "Adds a button to {C:attention}Reroll Vouchers{}",
            "for {C:money}$10{} {C:inactive}(+$5 per reroll){}",
            "Cost resets at {C:attention}Boss Blind{}"
        }
    },
    unlocked = true,
    discovered = true,
    atlas = 'CustomDecks',
    calculate = function(self, back, context)
        if context.end_of_round and context.beat_boss then
            if G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.config then
                G.GAME.selected_back.effect.config.voucher_reroll_cost = 10
            end
        end
    end
}

local orig_shop = G.UIDEF.shop
function G.UIDEF.shop()
    local t = orig_shop()
    
    local config = G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.config
    
    if config and config.voucher_reroll_cost then
        local function find_and_inject(node)
            if node.nodes then
                for i, child in ipairs(node.nodes) do
                    if child.config and child.config.object == G.shop_vouchers then
                        local original_voucher_node = child

                        original_voucher_node.config.minw = 1

                        node.nodes[i] = {
                            n = G.UIT.C, config = {align = "cr", padding = 0}, nodes = {
                                original_voucher_node,
                                {
                                    n = G.UIT.C, config = {align = "cm", padding = 0}, nodes = {
                                        UIBox_button({
                                            label = {"Reroll", "$" .. tostring(config.voucher_reroll_cost)},
                                            button = "reroll_vouchers",
                                            colour = G.C.PURPLE,
                                            minw = 1,
                                            minh = 3
                                        })
                                    }
                                },
                            }
                        }
                        return true
                    end
                    if find_and_inject(child) then
                        return true
                    end
                end
            end
            return false
        end
        find_and_inject(t)
    end
    
    return t
end

G.FUNCS.reroll_vouchers = function(e)
    local config = G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.config
    if not config then return end
    
    local cost = config.voucher_reroll_cost
    
    if G.GAME.dollars >= cost then
        ease_dollars(-cost)
        config.voucher_reroll_cost = cost + 5

        local new_cost_str = "$" .. tostring(config.voucher_reroll_cost)

        local function update_text(node)
            if node.config and type(node.config.text) == "string" and string.match(node.config.text, "^%$%d+$") then
                node.config.text = new_cost_str
                return true
            end
            if node.children then
                for _, child in pairs(node.children) do
                    if update_text(child) then return true end
                end
            end
            if node.nodes then
                for _, child in ipairs(node.nodes) do
                    if update_text(child) then return true end
                end
            end
            return false
        end

        update_text(e)
        if e.UIBox then e.UIBox:recalculate() end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if G.shop_vouchers and G.shop_vouchers.cards then
                    
                    for i = #G.shop_vouchers.cards, 1, -1 do
                        local c = G.shop_vouchers.cards[i]
                        c:remove()
                    end
                    
                    local max_vouchers = G.shop_vouchers.config.card_limit or 1
                    
                    for i = 1, max_vouchers do
                        SMODS.add_voucher_to_shop()
                    end
                    
                end
                return true
            end
        }))
    end
end