--Palkia & Dialga LEGEND (Triumphant 102/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_PALKIA_AND_DIALGA_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIRE,[2]=PM_ENERGY_LIGHTNING}
