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
--return
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BENCHEDPOKEMON)
	local g1=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g1:GetCount()==0 then return end
	local g2=g1:GetFirst():GetAttachmentGroup()
	g1:Merge(g2)
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(tp,g1)
end
--discard energy & to prize
function scard.tpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,CARD_METAL_ENERGY)
	Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD)
	local g2=Duel.GetDecktopGroup(1-tp,2)
	Duel.SendtoPrize(e,g2,1-tp,REASON_EFFECT)
end
