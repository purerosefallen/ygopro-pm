--Slowpoke (Fossil 55/62)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.healop)
	--to hand
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_TOHAND,scard.attack_cost2,scard.thtg,scard.thop,pm.decost(c,1,1,CARD_PSYCHIC_ENERGY))
end
scard.pokemon_card=true
scard.length=3.11
scard.evolve_list={[1]=CARD_SLOWBRO}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_PSYCHIC_ENERGY,2)
--heal
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	if c:GetCounter(PM_DAMAGE_COUNTER)==0 then return end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.HealDamage(e,10,c) end
end
--to hand
function scard.thfilter(c)
	return c:IsItem() and c:IsAbleToHand()
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,PM_CATEGORY_TOHAND,nil,1,tp,PM_LOCATION_DPILE)
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,PM_LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
