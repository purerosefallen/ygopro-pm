--Entei & Raikou LEGEND (Unleashed 91/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_ENTEI_AND_RAIKOU_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_WATER,[2]=PM_ENERGY_FIGHTING}
