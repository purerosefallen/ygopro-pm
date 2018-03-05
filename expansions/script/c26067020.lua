--Slowbro (BREAKpoint 20/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--win
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.winop)
end
scard.pokemon_card=true
scard.height=5.30
scard.devolve_list={[1]=CARD_SLOWPOKE}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+50 end
	if dam>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
--win
function scard.winop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	if Duel.GetPrizeGroupCount(tp,tp)==1 then Duel.Win(tp,PM_WIN_REASON_SLOWBRO) end
end
