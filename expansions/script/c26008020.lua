--Cleffa (Neo Genesis 20/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	c:SetStatus(PM_STATUS_NO_RETREAT_COST,true)
	pm.EnablePokemonAttribute(c)
	--baby
	pm.EnableBabyAttribute(c)
	--to deck & draw
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.drtg(PLAYER_PLAYER,7),scard.drop)
end
scard.pokemon_card=true
scard.length=1.00
scard.evolve_list={[1]=CARD_CLEFAIRY,[2]=CARD_CLEFABLE}
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,7,REASON_EFFECT)
end
