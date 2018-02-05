--Rayquaza C (Supreme Victors 8/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--discard hand
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.hdop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_COLORLESS
scard.resistance_20=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,4)
function scard.hdop(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	local g=Duel.GetMatchingGroup(Card.IsEnergy,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
		local sg=g:Select(tp,1,5,nil)
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
		local ct=sg:GetCount()*10
		dam=dam+ct
	end
	if dam>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	if ct==RESULT_TAILS+RESULT_TAILS then dam=0 end
	Duel.AttackDamage(dam)
	if ct==RESULT_TAILS+RESULT_TAILS then return end
	Duel.DiscardEnergy(e,Duel.GetDefendingPokemon(),ct)
end
