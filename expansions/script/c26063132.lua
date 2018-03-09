--Kyogre Spirit Link (Primal Clash 132/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,0)
	--do not end turn
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e1:SetCode(PM_EFFECT_DONOT_END_TURN_MEGA)
	e1:SetCondition(scard.effcon)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.effcon(e)
	return e:GetHandler():IsCode(CARD_PRIMAL_KYOGRE_EX)
end
