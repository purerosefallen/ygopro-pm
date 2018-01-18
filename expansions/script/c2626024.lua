--Magma Pointer (Double Crisis 24/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonTool(c,1,scard.damcon)
	--gain attack
	pm.AddPokemonToolAttack(c,0,nil,aux.AND(scard.damcon,pm.econ1(CARD_FIGHTING_ENERGY,1)),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
function scard.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSetCard(PM_SETNAME_TEAM_MAGMA)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_POKEMON)
	local tc=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil):GetFirst()
	Duel.AttackDamage(20,tc)
end
