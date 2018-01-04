--Haxorus (Noble Victories 88/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop)
	--cannot attack
	pm.EnablePokemonAttack(c,1,nil,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.abop)
end
scard.pokemon_card=true
scard.height=5.11
scard.devolve_list={CARD_FRAXURE,CARD_AXEW}
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	Duel.AttackDamage(ct*50)
end
function scard.abop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local tc=e:GetHandler()
	pm.EnableCannotAttack(tc,aux.Stringid(sid,2),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
