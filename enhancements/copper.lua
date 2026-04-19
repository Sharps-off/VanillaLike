
SMODS.Enhancement {
    key = 'copper',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Copper',
        text = {
            'Retrigger the first scoring',
            'card when this card is scored'
        }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,

    calculate = function(self, card, context, effect)
        if context.post_effect
        and context.cardarea == G.play
        and context.main_scoring
        and context.scoring_hand then

            local target_card = context.scoring_hand[1]

            if target_card and not target_card.debuff then
                return {
                    func = function()
                        while (card.config.copper_rescored_times or 0) < card.config.center.rescore_amount do

                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    if big_juice then big_juice(target_card) else target_card:juice_up() end
                                    return true 
                                end
                            }))

                            play_area_status_text(localize('bunc_repeat') or "Repeat!")

                            card.config.copper_rescored_times = (card.config.copper_rescored_times or 0) + 1
                            
                            SMODS.score_card(target_card, context)

                            SMODS.calculate_context({rescore_cards = {target_card}})
                        end
                        return true
                    end
                }
            end
        end

        if context.after and context.scoring_hand then
            for _, other_card in ipairs(context.scoring_hand) do
                other_card.config.copper_rescored_times = 0
            end
        end
    end
}