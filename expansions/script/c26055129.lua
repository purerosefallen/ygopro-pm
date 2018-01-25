--Scramble Switch (Plasma Storm 129/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--ace spec
	pm.EnableDeckRestriction(c,PM_EFFECT_RESTRICT_ACE_SPEC)
	--switch & move energy
	pm.EnableTrainerPlay(c,nil,scard.swtg,scard.swop)
end
scard.pokemon_card=true
function scard.swtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(pm.ActivePokemonFilter,tp,PM_LOCATION_ACTIVE,0,1,nil)
		and Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetAttackingPokemon():GetAttachmentGroup()
	Duel.SwitchPokemon(e,tp,tp)
	Duel.BreakEffect()
	if g:FilterCount(Card.IsEnergy,nil)==0 or not Duel.SelectYesNo(tp,aux.Stringid(sid,0)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ENERGY)
	local sg=g:FilterSelect(tp,Card.IsEnergy,1,g:GetCount(),nil)
	Duel.Attach(Duel.GetAttackingPokemon(),sg)
end
