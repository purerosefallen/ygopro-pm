--Lapras ex (EX Ruby & Sapphire 99/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--confused
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.conop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ag=e:GetHandler():GetAttachmentGroup()
	local ac=ag:GetFirst()
	if ac:IsEnergy(CARD_WATER_ENERGY) then ag:RemoveCard(ac) end
	local dam=10+ag:FilterCount(Card.IsEnergy,nil)*10
	if dam>30 then dam=30 end
	if dam>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
--confused
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	pm.EnableConfused(Duel.GetDefendingPokemon())
end
