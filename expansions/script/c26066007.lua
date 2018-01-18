--Chespin (BREAKthrough 7/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,scard.healtg,scard.healop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={CARD_QUILLADIN,CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.healtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetCounter(PM_DAMAGE_COUNTER)>0 end
end
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.HealDamage(e,20,e:GetHandler())
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
