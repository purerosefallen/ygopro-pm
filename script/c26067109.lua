--Puzzle of Time (BREAKpoint 109/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--sort deck or to hand
	pm.EnableTrainerPlay(c,0,scard.opttg,scard.optop)
end
scard.pokemon_card=true
function scard.opttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(nil,tp,LOCATION_DECK,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,PM_LOCATION_DPILE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,e:GetHandler(),CARD_PUZZLE_OF_TIME)
	if chk==0 then return b1 or b2 end
	local opt=0
	if b1 and b2 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0),aux.Stringid(sid,1))
	elseif b1 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(sid,1))+1
	end
	if opt==1 then e:SetCategory(PM_CATEGORY_RECYCLE) end
	e:SetLabel(opt)
end
function scard.optop(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==0 then
		Duel.SortDecktop(tp,tp,3)
	else
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,PM_LOCATION_DPILE,0,2,2,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
		local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,nil,CARD_PUZZLE_OF_TIME)
		Duel.SendtoDPile(tc,REASON_RULE)
	end
end
