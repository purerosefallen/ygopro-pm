--Torchic Star (EX Team Rocket Returns 108/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--star
	pm.EnableDeckRestriction(c,PM_EFFECT_RESTRICT_POKEMON_STAR)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop)
	--confused
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.conop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_FIRE_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_FIRE_ENERGY,2)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then Duel.DiscardEnergy(e,e:GetHandler(),1,1,CARD_FIRE_ENERGY) end
end
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	local ct=20
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then ct=ct+50 end
	if ct>20 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then pm.EnableConfused(Duel.GetDefendingPokemon()) end
end
