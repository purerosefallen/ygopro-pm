--Team Magma's Groudon-EX (Double Crisis 15/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--cannot attack
	pm.EnableCannotAttack(c,scard.effcon)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ2(CARD_FIGHTING_ENERGY,3,CARD_COLORLESS_ENERGY,1)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_TEAM_MAGMA)
end
function scard.effcon(e)
	return Duel.GetMatchingGroupCount(scard.cfilter,e:GetHandlerPlayer(),PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)<=4
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=60
	if Duel.GetDefendingPokemon():GetCounter(PM_DAMAGE_COUNTER)>0 then ct=ct+80 end
	if ct>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
