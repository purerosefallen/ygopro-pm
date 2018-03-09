--Kyogre-EX (Primal Clash 54/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--asleep
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.aslop)
	--return
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.retop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_PRIMAL_KYOGRE_EX}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--asleep
function scard.aslop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	pm.EnableAsleep(Duel.GetDefendingPokemon())
end
--return
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(140)
	local g=e:GetHandler():GetAttachmentGroup()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local sg=g:FilterSelect(tp,Card.IsEnergy,2,2,nil,CARD_WATER_ENERGY)
	if sg:GetCount()==0 then return end
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
