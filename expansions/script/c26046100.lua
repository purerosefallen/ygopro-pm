--Darkrai & Cresselia LEGEND (Triumphant 100/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_DARKRAI_AND_CRESSELIA_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIGHTING,[2]=PM_ENERGY_PSYCHIC}
