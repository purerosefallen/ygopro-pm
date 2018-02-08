--Kyogre & Groudon LEGEND (Undaunted 88/90)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_KYOGRE_AND_GROUDON_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_GRASS,[2]=PM_ENERGY_LIGHTNING}
