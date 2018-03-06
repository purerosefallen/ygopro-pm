--Xatu (Legendary Treasures 56/113)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--draw or discard deck
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.rpsop)
	--confused
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.conop)
end
scard.pokemon_card=true
scard.height=4.11
scard.devolve_list={[1]=CARD_NATU}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_PSYCHIC_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--draw or discard deck
function scard.rpsop(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.RockPaperScissors()
	if res==tp then
		Duel.Draw(tp,3,REASON_EFFECT)
		Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
	else
		Duel.Draw(1-tp,3,REASON_EFFECT)
		Duel.DiscardDeck(tp,3,REASON_EFFECT)
	end
end
--confused
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableConfused(Duel.GetDefendingPokemon()) end
end
