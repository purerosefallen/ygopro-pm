--Lugia LEGEND (HeartGold & SoulSilver 114/123)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_LUGIA_LEGEND
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.resistance_20=PM_ENERGY_FIGHTING
