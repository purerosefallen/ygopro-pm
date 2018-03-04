--Mudkip Star (EX Team Rocket Returns 107/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop)
	--asleep
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.aslop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_MARSHTOMP,[2]=CARD_SWAMPERT}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_WATER_ENERGY,2)
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetDefendingPokemon()
	Duel.PokemonAttack(c,tc)
	if not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,tc,1) end
end
--asleep
function scard.aslop(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then dam=dam+50 end
	if dam>20 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then pm.EnableAsleep(Duel.GetDefendingPokemon()) end
end
