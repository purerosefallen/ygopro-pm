--Fluffy Berry (Unseen Forces 85/115)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonTool(c,0)
	--no retreat cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_NO_RETREAT_COST)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
