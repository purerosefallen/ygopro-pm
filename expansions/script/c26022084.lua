--Pokémon Retriever (EX Team Rocket Returns 84/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to hand or to deck
	pm.EnableTrainerPlay(c,nil,scard.opttg,scard.optop)
end
scard.pokemon_card=true
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.tdfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToDeck()
end
function scard.opttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(scard.thfilter,tp,PM_LOCATION_DPILE,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(scard.tdfilter,tp,PM_LOCATION_DPILE,0,1,nil)
	if chk==0 then return b1 or b2 end
	local opt=0
	if b1 and b2 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0),aux.Stringid(sid,1))
	elseif b1 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(sid,1))+1
	end
	if opt==0 then
		e:SetCategory(PM_CATEGORY_TOHAND)
		Duel.SetOperationInfo(0,PM_CATEGORY_TOHAND,nil,1,tp,PM_LOCATION_DPILE)
	else
		e:SetCategory(0)
	end
	e:SetLabel(opt)
end
function scard.optop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,PM_LOCATION_DPILE,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,PM_LOCATION_DPILE,0,3,3,nil)
		if g:GetCount()==0 then return end
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	end
end
