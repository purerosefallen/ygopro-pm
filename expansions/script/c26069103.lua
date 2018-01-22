--Lass's Special (Fates Collide 103/124)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.bfilter(c)
	return c:IsFaceup() and c:IsBasicPokemon() and c:IsBench()
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(scard.bfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.bfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
