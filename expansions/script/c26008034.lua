--Flaaffy (Neo Genesis 34/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop,scard.damcost)
	--attach
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.atop)
end
scard.pokemon_card=true
scard.length=2.70
scard.evolve_list={[1]=CARD_AMPHAROS}
scard.devolve_list={[1]=CARD_MAREEP}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_LIGHTNING_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_LIGHTNING_ENERGY,2)
--damage
function scard.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetAttachmentGroup()
	if chk==0 then return g:IsExists(Card.IsEnergy,1,nil,CARD_LIGHTNING_ENERGY) end
	local sg=g:Filter(Card.IsEnergy,nil,CARD_LIGHTNING_ENERGY)
	local ct=Duel.SendtoDPile(sg,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local dam=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then dam=dam+1 end
		ct=ct-1
	until ct==0
	Duel.AttackDamage(30*dam)
end
--attach
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	local g1=e:GetHandler():GetAttachmentGroup()
	local g2=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:FilterCount(Card.IsEnergy,nil,CARD_LIGHTNING_ENERGY)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_LENERGY)
	local sg1=g1:FilterSelect(tp,Card.IsBasicEnergy,1,1,nil,CARD_LIGHTNING_ENERGY)
	if g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.Attach(sg2:GetFirst(),sg1)
	else Duel.SendtoDPile(sg1,REASON_EFFECT+REASON_DISCARD) end
end
