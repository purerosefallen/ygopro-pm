--Entei & Raikou LEGEND (Unleashed 90/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop1)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop2)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_ENTEI_AND_RAIKOU_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_WATER,[2]=PM_ENERGY_FIGHTING}
scard.attack_cost1=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.deop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(90)
	Duel.DiscardEnergy(e,e:GetHandler(),1,1,CARD_FIRE_ENERGY)
end
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsHasPokePower()
end
function scard.deop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD)
	local g2=Duel.GetMatchingGroup(scard.defilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	if g2:GetCount()==0 then return end
	local tc=g2:GetFirst()
	for tc in aux.Next(g2) do
		Duel.EffectDamage(80,c,tc,false,false)
	end
end
