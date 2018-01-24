--Team Aqua's Sharpedo (Double Crisis 21/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	c:SetStatus(PM_STATUS_NO_RETREAT_COST,true)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.thtg)
	e1:SetOperation(scard.thop)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=5.11
scard.devolve_list={[1]=CARD_TEAM_AQUAS_CARVANHA}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost=pm.econ2(CARD_DARKNESS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.thfilter(c)
	return c:IsPokemon() and c:IsSetCard(PM_SETNAME_TEAM_AQUA) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(70)
end
