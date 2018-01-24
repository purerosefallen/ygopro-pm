--Psychic Memory (Crimson Invasion 98/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,0)
	--add type
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_ADD_POKEMON_TYPE)
	e1:SetCondition(scard.typecon)
	e1:SetValue(PM_ENERGY_PSYCHIC)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.typecon(e)
	return e:GetHandler():IsCode(CARD_SILVALLY_GX)
end
