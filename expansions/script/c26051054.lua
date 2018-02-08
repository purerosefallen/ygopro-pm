--Mewtwo-EX (Next Destinies 54/99)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_M_MEWTWO_EX}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_PSYCHIC_ENERGY,2,CARD_COLORLESS_ENERGY,1)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local a=e:GetHandler()
	local d=Duel.GetDefendingPokemon()
	local dam=a:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)+d:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)
	if dam>0 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(20*dam)
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	Duel.DiscardEnergy(e,e:GetHandler(),1)
end
