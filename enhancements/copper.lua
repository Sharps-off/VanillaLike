
SMODS.Enhancement {
    key = 'copper',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Copper',
        text = {
            [1] = 'Retrigger the first scoring',
            [2] = 'card when this card is scored'
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
        -- Vérifications de base (zone de jeu, scoring principal, etc.)
        if context.post_effect
        and context.cardarea == G.play
        and context.main_scoring
        and context.scoring_hand then

            local target_card = context.scoring_hand[1]

            if target_card and not target_card.debuff then
                return {
                    func = function()
                        while (card.config.copper_rescored_times or 0) < card.config.center.rescore_amount do

                            -- Effet visuel (Juice) sur la carte cible
                            -- J'ai gardé ton 'big_juice' s'il est défini globalement, sinon juice standard
                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    if big_juice then big_juice(target_card) else target_card:juice_up() end
                                    return true 
                                end
                            }))

                            -- Texte flottant (ex: "Repeat!")
                            play_area_status_text(localize('bunc_repeat') or "Repeat!")

                            -- Incrémenter le compteur pour éviter les boucles infinies sur cette carte Copper
                            card.config.copper_rescored_times = (card.config.copper_rescored_times or 0) + 1
                            
                            -- Effectuer le nouveau calcul de score sur la carte cible
                            SMODS.score_card(target_card, context)

                            -- Mise à jour du contexte SMODS
                            SMODS.calculate_context({rescore_cards = {target_card}})
                        end
                        return true
                    end
                }
            end
        end

        -- Reset du compteur à la fin de la main (inchangé)
        if context.after and context.scoring_hand then
            for _, other_card in ipairs(context.scoring_hand) do
                other_card.config.copper_rescored_times = 0
            end
        end
    end
}