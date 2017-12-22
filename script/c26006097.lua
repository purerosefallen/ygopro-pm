--Blaine's Quiz #1 (Gym Heroes 97/132)
--Not fully implemented: Cannot announce decimals with Duel.AnnounceNumber
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
os=require('os')
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerActivate(c,0,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.filter(c)
	return c.length and (c:IsBasicPokemon() or c:IsEvolution()) and c:IsSecret()
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.filter,tp,LOCATION_HAND,0,1,nil) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,0))
	local g=Duel.SelectMatchingCard(tp,scard.filter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
	Duel.Hint(HINT_CODE,0,tc:GetOriginalCode())
	local end_time=0
	local start_time=os.time()
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(sid,1))
	local an=Duel.AnnounceNumber(1-tp,table.unpack(pm.length_list))
	end_time=os.time()-start_time
	if end_time>10 or an~=math.floor(tc.length) then
		Duel.Draw(tp,2,REASON_EFFECT)
	else
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.HintSelection(g)
		Duel.Draw(1-tp,2,REASON_EFFECT)
	end
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
