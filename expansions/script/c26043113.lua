--Lugia LEGEND (HeartGold & SoulSilver 113/123)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--poké-power (attach)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(pm.ppowcon)
	e1:SetTarget(scard.attg)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_LUGIA_LEGEND
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.resistance_20=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ3(CARD_FIRE_ENERGY,1,CARD_WATER_ENERGY,1,CARD_LIGHTNING_ENERGY,1)
--poké-power (attach)
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(Card.IsEnergy,1,nil) then
		local sg=g:Filter(Card.IsEnergy,nil)
		g:Sub(sg)
		if sg:GetCount()>0 then
			Duel.DisableShuffleCheck()
			Duel.Attach(e:GetHandler(),sg)
		end
		if g:GetCount()>0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
		end
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	end
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(200)
	Duel.DiscardEnergy(e,e:GetHandler(),1,1,CARD_FIRE_ENERGY,1,1,CARD_WATER_ENERGY,1,1,CARD_LIGHTNING_ENERGY)
end
