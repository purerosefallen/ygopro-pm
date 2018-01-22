--Lillie (Sun & Moon 122/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local n=6
	if Duel.GetTurnPlayer()==tp and (Duel.IsFirstTurn() or Duel.GetTurnCount()==2) then n=8 end
	local ct=n-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local n=6
	if Duel.GetTurnPlayer()==tp and (Duel.IsFirstTurn() or Duel.GetTurnCount()==2) then n=8 end
	local ct=n-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct<=0 then return end
	Duel.Draw(tp,ct,REASON_EFFECT)
end
