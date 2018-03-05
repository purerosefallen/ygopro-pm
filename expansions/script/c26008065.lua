--Mareep (Neo Genesis 65/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--attach
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.atop)
	--paralyzed
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.length=2.70
scard.evolve_list={[1]=CARD_FLAAFFY,[2]=CARD_AMPHAROS}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_LIGHTNING_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_LIGHTNING_ENERGY,2)
--attach
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCode(sid)
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g1=Duel.GetMatchingGroup(scard.cfilter,tp,PM_LOCATION_ACTIVE,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsEnergy,tp,LOCATION_DECK,0,nil,CARD_LIGHTNING_ENERGY)
	local ct=g1:GetCount()
	if ct==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_LENERGY)
	local sg=g2:Select(tp,ct,ct,nil)
	Duel.Attach(c,sg)
end
--paralyzed
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
