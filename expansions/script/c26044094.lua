--Suicune & Entei LEGEND (Unleashed 94/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--return
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.retop)
	--burned
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.burop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_SUICUNE_AND_ENTEI_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_WATER,[2]=PM_ENERGY_LIGHTNING}
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--return
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g=c:GetAttachmentGroup()
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local sg1=g:FilterSelect(tp,Card.IsEnergy,2,2,nil,CARD_WATER_ENERGY)
		if sg1:GetCount()==0 then return end
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DAMAGE)
	local sg2=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if sg2:GetCount()==0 then return end
	Duel.HintSelection(sg2)
	Duel.EffectDamage(100,c,sg2:GetFirst(),false,false)
end
--burned
function scard.burop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	pm.EnableBurned(Duel.GetDefendingPokemon())
end
