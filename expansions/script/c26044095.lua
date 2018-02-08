--Suicune & Entei LEGEND (Unleashed 95/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_SUICUNE_AND_ENTEI_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_WATER,[2]=PM_ENERGY_LIGHTNING}
