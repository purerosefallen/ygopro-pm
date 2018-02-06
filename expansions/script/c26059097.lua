--Xerneas-EX (XY 97/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2,scard.damcon)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_METAL
scard.resistance_20=PM_ENERGY_DARKNESS
scard.attack_cost1=pm.econ2(CARD_FAIRY_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_FAIRY_ENERGY,2,CARD_COLORLESS_ENERGY,2)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DAMAGE)
	local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.EffectDamage(30,e:GetHandler(),g:GetFirst(),false,false)
end
function scard.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)==0
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(140)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,3,0,aux.Stringid(sid,2))
end
