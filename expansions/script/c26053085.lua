--Rayquaza-EX (Dragons Exalted 85/124)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--discard deck & attach
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.atop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_M_RAYQUAZA_EX}
scard.weakness_x2=PM_ENERGY_DRAGON
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_LIGHTNING_ENERGY,1)
--discard deck & attach
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
	local og=Duel.GetOperatedGroup():Filter(Card.IsEnergy,1,nil)
	if og:GetCount()==0 then return end
	Duel.Attach(e:GetHandler(),og)
end
--damage
function scard.cfilter(c,energy)
	return c:IsBasicEnergy() and c:IsEnergy(energy)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local c=e:GetHandler()
	local b1=c:GetAttachmentGroup():IsExists(scard.cfilter,1,nil,CARD_FIRE_ENERGY)
	local b2=c:GetAttachmentGroup():IsExists(scard.cfilter,1,nil,CARD_LIGHTNING_ENERGY)
	local opt=0
	if b1 and b2 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,2),aux.Stringid(sid,3))
	elseif b1 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,2))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(sid,3))+1
	end
	local g=nil
	if opt==0 then
		g=c:GetAttachmentGroup():Filter(scard.cfilter,nil,CARD_FIRE_ENERGY)
	else
		g=c:GetAttachmentGroup():Filter(scard.cfilter,nil,CARD_LIGHTNING_ENERGY)
	end
	dam=dam*Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	if dam>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
