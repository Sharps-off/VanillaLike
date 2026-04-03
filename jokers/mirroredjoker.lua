
SMODS.Joker{ --Mirrored Joker
    key = "mirroredjoker",
    config = {
        extra = {
            Pos = 1,
            index = 0,
            text = 0
        }
    },
    loc_txt = {
        ['name'] = 'Mirrored Joker',
        ['text'] = {
            [1] = 'Copies ability of a',
            [2] = '{C:attention}random{} owned Joker',
            [3] = '{s:0.7,C:default}Joker change when a blind is selected{}',
            [4] = '{C:inactive}(Currently : {}{C:attention}#1#{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["vl_vl_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        local target_key = card.ability.extra.text
        local joker_name = "None" 
        
        if target_key and target_key ~= 0 then
            -- Localisation du nom en utilisant la clé sauvegardée [9]
            joker_name = localize({type = 'name_text', set = 'Joker', key = target_key})
        end
        
        -- #1# affichera le nom localisé du Joker copié.
        return {vars = {joker_name}} 
    end,
    
    calculate = function(self, card, context)

        if context.end_of_round and context.cardarea == G.jokers then
            
            -- 1. Filtrer tous les jokers, excluant le Mirrored Joker lui-même
            local other_jokers = {}
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    other_jokers[#other_jokers + 1] = joker
                end
            end

            local selected_joker_key = nil
            
            if #other_jokers > 0 then
                -- 2. Choisir un Joker aléatoire parmi les autres Jokers
                local target_joker_object, _ = pseudorandom_element(other_jokers, pseudoseed('mirrored_target_seed' .. G.GAME.round_resets.ante))
                
                -- 3. Sauvegarder la clé du Joker cible pour la persistance (indépendant de la position)
                if target_joker_object and target_joker_object.config and target_joker_object.config.center then
                    selected_joker_key = target_joker_object.config.center.key -- Récupère la clé (e.g., 'j_joker') [5]
                    card.ability.extra.text = selected_joker_key -- Mise à jour de la clé sauvegardée
                end
            else
                -- Si aucun autre Joker n'est présent, on met la clé à nil/0
                card.ability.extra.text = 0
            end

            return {
                func = function()
                    return true
                end,
                extra = {
                    message = "Rerolled"
                }
            }
        end

        local target_joker = nil
        local target_key = card.ability.extra.text
        
        if target_key and target_key ~= 0 then
            local matching_jokers = SMODS.find_card(target_key) 
            if matching_jokers and matching_jokers then
                target_joker = matching_jokers
            end
        end

        if target_joker == card then 
            target_joker = nil 
        end

        local ret = SMODS.blueprint_effect(card, target_joker, context)

        if ret then
            SMODS.calculate_effect(ret, card)
        end

    end
}