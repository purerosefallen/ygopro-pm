--Chespin (BREAKthrough 7/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.healop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={[1]=CARD_QUILLADIN,[2]=CARD_CHESNAUGHT,[3]=CARD_CHESNAUGHT_BREAK}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--heal
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	if c:GetCounter(PM_DAMAGE_COUNTER)>0 then Duel.HealDamage(e,20,c) end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
