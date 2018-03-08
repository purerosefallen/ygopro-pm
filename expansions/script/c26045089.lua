--Rayquaza & Deoxys LEGEND (Undaunted 89/90)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--poké-body (increase prize)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_EXTRA_PRIZE_KNOCKED_OUT)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(pm.pbodcon)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_RAYQUAZA_AND_DEOXYS_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_PSYCHIC,[2]=PM_ENERGY_COLORLESS}
scard.attack_cost=pm.econ3(CARD_FIRE_ENERGY,2,CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(150)
	local g=e:GetHandler():GetAttachmentGroup():Filter(Card.IsEnergy,nil,CARD_FIRE_ENERGY)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
end
