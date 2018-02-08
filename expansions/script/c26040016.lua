--Bronzong 4 (Rising Rivals 16/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--to deck & draw
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.drop)
	--confused
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.conop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.resistance_20=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ0()
scard.attack_cost2=pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,1)
--to deck & draw
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	local d1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local d2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if d1>0 and Duel.SelectYesNo(tp,PM_QHINTMSG_DRAW) then
		local t={}
		for i=4,1,-1 do
			if d1>=i then table.insert(t,i) end
		end
		if #t==1 then
			Duel.Draw(tp,t[1],REASON_EFFECT)
		else
			Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_NUMBERDRAW)
			local ct=Duel.AnnounceNumber(tp,table.unpack(t))
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	end
	if d2>0 and Duel.SelectYesNo(1-tp,PM_QHINTMSG_DRAW) then
		local t={}
		for i=4,1,-1 do
			if d2>=i then table.insert(t,i) end
		end
		if #t==1 then
			Duel.Draw(1-tp,t[1],REASON_EFFECT)
		else
			Duel.Hint(HINT_SELECTMSG,1-tp,PM_HINTMSG_NUMBERDRAW)
			local ct=Duel.AnnounceNumber(1-tp,table.unpack(t))
			Duel.Draw(1-tp,ct,REASON_EFFECT)
		end
	end
end
--confused
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then dam=dam+50 end
	if dam>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then pm.EnableConfused(Duel.GetDefendingPokemon()) end
end
