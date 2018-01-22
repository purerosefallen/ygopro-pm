--Team Rocket's Handiwork (Fates Collide 112/124)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard deck
	pm.EnableTrainerPlay(c,nil,scard.ddtg,scard.ddop)
end
scard.pokemon_card=true
function scard.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function scard.ddop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)<=0 then return end
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	Duel.DiscardDeck(1-tp,ct*2,REASON_EFFECT)
end
