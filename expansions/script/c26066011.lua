--Chesnaught (BREAKthrough 11/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--damage reduce
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.effop)
end
scard.pokemon_card=true
scard.height=5.03
scard.evolve_list={[1]=CARD_CHESNAUGHT_BREAK}
scard.devolve_list={[1]=CARD_QUILLADIN,[2]=CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,2,CARD_COLORLESS_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=60
	if Duel.GetDefendingPokemon():GetCounter(PM_DAMAGE_COUNTER)>0 then ct=ct+60 end
	if ct>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(100)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_DAMAGE_ATTACK_REDUCE_20)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
end
