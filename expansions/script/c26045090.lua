--Rayquaza & Deoxys LEGEND (Undaunted 90/90)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
end
scard.pokemon_card=true
scard.legend_bottom_half=CARD_RAYQUAZA_AND_DEOXYS_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_PSYCHIC,[2]=PM_ENERGY_COLORLESS}
