--Raikou & Suicune LEGEND (Unleashed 93/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_RAIKOU_AND_SUICUNE_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIGHTING,[2]=PM_ENERGY_LIGHTNING}
