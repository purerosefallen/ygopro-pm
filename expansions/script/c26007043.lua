--Giovanni's Meowth (Gym Challenge 43/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--confirm
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.confop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=1.40
scard.evolve_list={[1]=CARD_GIOVANNIS_PERSIAN}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_30=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,2)
--confirm
function scard.confop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local g=Duel.GetDecktopGroup(1-tp,1)
		if g:GetCount()==0 then return end
		local tc=g:GetFirst()
		Duel.ConfirmCards(tp,tc)
		if tc:IsTrainer() then
			Duel.SendtoDPile(tc,REASON_EFFECT)
		else
			Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(tp,tc)
		end
	end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(20*dam)
end
