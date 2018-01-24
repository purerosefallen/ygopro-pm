--Team Plasma Badge (Plasma Freeze 104/116)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,0)
	--add setcode
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_ADD_SETCODE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetValue(PM_SETNAME_TEAM_PLASMA)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
