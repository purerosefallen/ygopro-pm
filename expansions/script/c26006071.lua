--Brock's Sandshrew (Gym Heroes 71/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--immune
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.imop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=2.00
scard.evolve_list={[1]=CARD_BROCKS_SANDSLASH}
scard.weakness_x2=PM_ENERGY_GRASS
scard.resistance_30=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
--immune
function scard.imop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,2))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(PM_EFFECT_IMMUNE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
	end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
