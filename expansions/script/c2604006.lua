--Dark Ivysaur (Best of Game 6)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-body (switch)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+PM_EVENT_RETREAT)
	e1:SetCondition(aux.AND(pm.turnpcon(PLAYER_PLAYER),pm.pbodcon))
	e1:SetOperation(scard.swop)
	c:RegisterEffect(e1)
	--add marker
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.ctop)
end
scard.pokemon_card=true
scard.length=3.30
scard.evolve_list={[1]=CARD_VENUSAUR}
scard.devolve_list={[1]=CARD_BULBASAUR}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_GRASS_ENERGY,2)
--poké-body (switch)
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SwitchPokemon(e,tp,1-tp)
end
--add marker
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetMarker(PM_DARK_IVYSAUR_MARKER)>0
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local count=3
	repeat
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(sid,2))
		local g1=Duel.SelectMatchingCard(1-tp,scard.ctfilter,1-tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
		if g1:GetCount()==0 then return end
		Duel.HintSelection(g1)
		g1:GetFirst():AddCounter(PM_DARK_IVYSAUR_MARKER,1)
		count=count-1
	until count==0
	Duel.BreakEffect()
	local g2=Duel.GetMatchingGroup(scard.damfilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	local tc=g2:GetFirst()
	for tc in aux.Next(g2) do
		local dam=tc:GetMarker(PM_DARK_IVYSAUR_MARKER)
		Duel.EffectDamage(10*dam,c,tc)
	end
end
