--Team Aqua Grunt (Double Crisis 26/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,3),scard.drop,nil,scard.drcost)
end
scard.pokemon_card=true
function scard.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDPileAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDPileAsCost,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
	e:SetLabelObject(g:GetFirst())
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	local tc=e:GetLabelObject()
	if not (tc:IsPokemon() and tc:IsSetCard(PM_SETNAME_TEAM_AQUA)) then return end
	Duel.Draw(tp,1,REASON_EFFECT)
end
