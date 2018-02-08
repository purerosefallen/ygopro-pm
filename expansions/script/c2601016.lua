--Computer Error (Black Star Promo Wizards of the Coast 16)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct1>0 then
		local t={}
		for i=1,ct1 do
			t[i]=i
		end
		if Duel.SelectYesNo(tp,PM_QHINTMSG_DRAW) then
			Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_NUMBERDRAW)
			local an=Duel.AnnounceNumber(tp,table.unpack(t))
			Duel.Draw(tp,an,REASON_EFFECT)
		end
	end
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct2>0 then
		local t={}
		for i=1,ct2 do
			t[i]=i
		end
		if Duel.SelectYesNo(1-tp,PM_QHINTMSG_DRAW) then
			Duel.Hint(HINT_SELECTMSG,1-tp,PM_HINTMSG_NUMBERDRAW)
			local an=Duel.AnnounceNumber(1-tp,table.unpack(t))
			Duel.Draw(1-tp,an,REASON_EFFECT)
		end
	end
	Duel.BreakEffect()
	pm.EndTurn(e)
end
