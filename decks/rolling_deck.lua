
SMODS.Back {
    key = 'rolling_deck',
    pos = { x = 3, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Rolling Deck',
        text = {
            [1] = 'After skiping a blind,',
            [2] = 'gain a {C:attention}Boss Tag{}'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.GAME.reroll_tag_on_skip = true
    end
}

skip_blind_ref = G.FUNCS.skip_blind

function G.FUNCS.skip_blind(e)
    if(G.GAME.reroll_tag_on_skip) then
        local boss_tag = Tag('tag_boss')
        add_tag(boss_tag)
    end
    local ret = skip_blind_ref(e)
end
