--Kyurem-EX (Next Destinies 38/99)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop,scard.damcon)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_METAL
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	local tc=Duel.GetDefendingPokemon()
	if not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
	Duel.DiscardEnergy(e,tc,1,1,PM_TYPE_SPECIAL_ENERGY)
end
--damage
function scard.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)==0
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,3,0,aux.Stringid(sid,2))
end
