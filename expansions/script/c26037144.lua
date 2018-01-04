--Mewtwo LV.X (Legends Awakened 144/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--level up
	pm.EnableLevelUp(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_IMMUNE_ATTACK_NONEVOLVED)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,pm.econ2(CARD_PSYCHIC_ENERGY,2,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.levelup_list={CARD_MEWTWO}
scard.weakness_x2=PM_ENERGY_PSYCHIC
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local g=e:GetHandler():GetAttachmentGroup():Filter(Card.IsEnergy,nil)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
end
