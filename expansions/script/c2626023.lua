--Aqua Diffuser (Double Crisis 23/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,1,scard.spcon)
	--gain attack (confused & poisoned)
	pm.AddTrainerAttack(c,0,nil,aux.AND(scard.attack_cost,scard.spcon),pm.hinttg,scard.spop,PM_TYPE_TEAM_AQUA)
end
scard.pokemon_card=true
scard.attack_cost=pm.econ1(CARD_WATER_ENERGY,1)
function scard.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSetCard(PM_SETNAME_TEAM_AQUA)
end
function scard.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDefendingPokemon()
	pm.EnableConfused(tc)
	pm.EnablePoisoned(tc)
end
