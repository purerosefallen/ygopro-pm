--Victory Piece (Plasma Storm 130/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,0)
	--ignore energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_IGNORE_ENERGY)
	e1:SetRange(PM_LOCATION_ACTIVE)
	e1:SetCondition(scard.effcon)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.effcon(e)
	return e:GetHandler():IsCode(CARD_VICTINI_EX)
end
