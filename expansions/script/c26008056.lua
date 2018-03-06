--Cyndaquil (Neo Genesis 56/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--cannot attack
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.effop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=1.80
scard.evolve_list={[1]=CARD_QUILAVA,[2]=CARD_TYPHLOSION}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,1)
--cannot attack
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetDefendingPokemon()
	Duel.PokemonAttack(c,tc)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,2))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(PM_EFFECT_CANNOT_BE_ATTACKED)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetRange(PM_LOCATION_ACTIVE)
		e1:SetCondition(pm.activecon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetDescription(aux.Stringid(sid,3))
		e2:SetCode(PM_EFFECT_CANNOT_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		tc:RegisterEffect(e2)
	end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20,Duel.GetDefendingPokemon(),false,false,false)
end
