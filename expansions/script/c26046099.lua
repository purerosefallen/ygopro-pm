--Darkrai & Cresselia LEGEND (Triumphant 99/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--move counter
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.ctop)
	--to lost
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.tlop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_DARKRAI_AND_CRESSELIA_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIGHTING,[2]=PM_ENERGY_PSYCHIC}
scard.attack_cost1=pm.econ1(CARD_PSYCHIC_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_DARKNESS_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--move counter
function scard.cfilter1(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.cfilter2(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetCounter(PM_DAMAGE_COUNTER)==0
end
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g1=Duel.GetMatchingGroup(scard.cfilter1,tp,0,PM_LOCATION_IN_PLAY,nil)
	local g2=Duel.GetMatchingGroup(scard.cfilter2,tp,0,PM_LOCATION_IN_PLAY,nil)
	local g3=Duel.GetMatchingGroup(scard.ctfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_REMOVEDAMAGE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.HintSelection(sg1)
		local tc1=sg1:GetFirst()
		local t={}
		local i=1
		local p=1
		local v=tc1:GetCounter(PM_DAMAGE_COUNTER)
		for i=1,v do
			t[p]=i p=p+1
		end
		for i=1,6 do t[i]=i end
		t[p]=nil
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_NUMBERDAMAGE)
		local ct1=Duel.AnnounceNumber(tp,table.unpack(t))
		tc1:RemoveCounter(tp,PM_DAMAGE_COUNTER,ct1,REASON_EFFECT)
		g1:RemoveCard(tc1)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEDAMAGE)
		local sg2=g3:Select(tp,1,1,tc1)
		local tc2=sg2:GetFirst()
		tc2:AddCounter(PM_DAMAGE_COUNTER,ct1,REASON_EFFECT)
	until g1:GetCount()==0
end
--to lost
function scard.tlop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ag=c:GetAttachmentGroup()
	if ag:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOLZONE)
		local sg=ag:FilterSelect(tp,Card.IsEnergy,2,2,nil)
		if sg:GetCount()==0 then return end
		Duel.SendtoLost(sg,POS_FACEUP,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_TO_DPILE_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(0,PM_LOCATION_IN_PLAY+PM_LOCATION_ATTACHED)
	e1:SetTarget(scard.retg)
	e1:SetValue(PM_LOCATION_LOST)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	Duel.AttackDamage(100)
end
function scard.retg(e,c)
	return c:IsReason(PM_REASON_ATTACK)	or c:IsLocation(PM_LOCATION_ATTACHED)
end
