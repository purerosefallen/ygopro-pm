--Bodybuilding Dumbbells (Burning Shadows 113/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,0)
	--hp up
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_UPDATE_HP)
	e1:SetCondition(scard.hpcon)
	e1:SetValue(40)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.hpcon(e)
	return e:GetHandler():IsStage1()
end
