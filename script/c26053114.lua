--Giant Cape (Dragons Exalted 114/124)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonTool(c,0)
	--hp up
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_UPDATE_HP)
	e1:SetValue(20)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
