--Palkia & Dialga LEGEND (Triumphant 101/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--return
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.retop)
	--discard energy & to prize
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.tpop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_PALKIA_AND_DIALGA_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIRE,[2]=PM_ENERGY_LIGHTNING}
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_METAL_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BENCHEDPOKEMON)
	local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	local ag=g:GetFirst():GetAttachmentGroup()
	g:Merge(ag)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(tp,g)
end
function scard.tpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local ag=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,CARD_METAL_ENERGY)
	Duel.SendtoDPile(ag,REASON_EFFECT+REASON_DISCARD)
	local dg=Duel.GetDecktopGroup(1-tp,2)
	Duel.SendtoPrize(e,dg,1-tp,REASON_EFFECT)
end
