--Team Aqua's Muk (Double Crisis 8/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--retreat cost up
	pm.EnableRetreatCostChange(c,1,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=3.11
scard.devolve_list={[1]=CARD_TEAM_AQUAS_GRIMER}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.rctg(e,c)
	return c:IsFaceup() and c:IsPokemon() and not c:IsSetCard(PM_SETNAME_TEAM_AQUA)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=60
	if Duel.GetDefendingPokemon():IsAffectedBySpecialCondition() then ct=ct+60 end
	if ct>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
