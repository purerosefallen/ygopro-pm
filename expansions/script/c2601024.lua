--_____'s Pikachu (Black Star Promo Wizards of the Coast 24)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
os=require('os')
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=1.40
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ1(CARD_LIGHTNING_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=30
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,1))
	local month=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
	local day=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)
	local m,d=scard.GetDate()
	if m==month and d==day then
		if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=80 end
	end
	if ct>30 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
function scard.GetDate()
	local date=os.date("*t")
	return date.month,date.day
end
