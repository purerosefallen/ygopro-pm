--Misty's Duel (Gym Heroes 123/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) or Duel.IsPlayerCanDraw(1-tp,5) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(sid,0)) then
		local res=Duel.RockPaperScissors()
		if res==tp then
			scard.shuffle_draw(tp,tp,5)
		else
			scard.shuffle_draw(tp,1-tp,5)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
		local coin=Duel.SelectOption(tp,SELECT_HEADS,SELECT_TAILS)
		local res=Duel.TossCoin(tp,1)
		if coin~=res then
			scard.shuffle_draw(tp,tp,5)
		else
			scard.shuffle_draw(tp,1-tp,5)
		end
	end
end
function scard.shuffle_draw(tp,player,count)
	local g=Duel.GetFieldGroup(player,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(player)
	Duel.BreakEffect()
	Duel.Draw(player,count,REASON_EFFECT)
end
