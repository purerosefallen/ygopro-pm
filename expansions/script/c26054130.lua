--Hugh (Boundaries Crossed 130/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw or discard hand
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local h1=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	local h2=Duel.GetMatchingGroupCount(nil,tp,0,LOCATION_HAND,nil)
	local ct1=5-h1
	local ct2=5-h2
	if h1==5 and h2==5 then return false end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct1) or Duel.IsPlayerCanDraw(1-tp,ct2) or h1~=5 or h2~=5 end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,nil)
	local h2=Duel.GetMatchingGroupCount(nil,tp,0,LOCATION_HAND,nil)
	local min1=h1-5
	local min2=h2-5
	local ct1=5-h1
	local ct2=5-h2
	if h2>5 then Duel.DiscardHand(1-tp,nil,min2,min2,REASON_EFFECT+REASON_DISCARD)
	elseif h2<5 then Duel.Draw(1-tp,ct2,REASON_EFFECT) end
	if h1>5 then Duel.DiscardHand(tp,nil,min1,min1,REASON_EFFECT+REASON_DISCARD)
	elseif h1<5 then Duel.Draw(tp,ct1,REASON_EFFECT) end
end
