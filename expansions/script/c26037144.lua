--Mewtwo LV.X (Legends Awakened 144/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--level up
	pm.EnableLevelUpAttribute(c)
	--poké-body (immune)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_IMMUNE_ATTACK_NONEVOLVED)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(pm.pbodcon)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.levelup_list={CARD_MEWTWO}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_PSYCHIC_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local g=e:GetHandler():GetAttachmentGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
end
