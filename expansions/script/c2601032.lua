--Smeargle (Black Star Promo Wizards of the Coast 32)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--change type
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.typeop)
end
scard.pokemon_card=true
scard.length=3.11
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_30=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.typeop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetDefendingPokemon()
	Duel.PokemonAttack(c,tc)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local typ=tc:GetPokemonType()
	local available_list={}
	if typ~=PM_ENERGY_GRASS then table.insert(available_list,1) end
	if typ~=PM_ENERGY_FIRE then table.insert(available_list,2) end
	if typ~=PM_ENERGY_WATER then table.insert(available_list,3) end
	if typ~=PM_ENERGY_LIGHTNING then table.insert(available_list,4) end
	if typ~=PM_ENERGY_PSYCHIC then table.insert(available_list,5) end
	if typ~=PM_ENERGY_FIGHTING then table.insert(available_list,6) end
	if typ~=PM_ENERGY_DARKNESS then table.insert(available_list,7) end
	if typ~=PM_ENERGY_METAL then table.insert(available_list,8) end
	if typ~=PM_ENERGY_FAIRY then table.insert(available_list,9) end
	if typ~=PM_ENERGY_DRAGON then table.insert(available_list,10) end
	if #available_list==0 then return end
	local option_list={}
	for i,v in pairs(available_list) do
		table.insert(option_list,pm.select_list[v])
	end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ENERGYTYPE)
	local opt=available_list[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local desc=aux.Stringid(sid,opt)
	local val=pm.energy_list[opt]
	--add counter
	if tc:GetCounter(PM_COLORING_COUNTER)>0 then
		tc:RemoveCounter(tp,PM_COLORING_COUNTER,1,REASON_EFFECT)
		tc:ResetFlagEffect(0)
	end
	tc:AddCounter(PM_COLORING_COUNTER,1)
	--change type
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_CHANGE_POKEMON_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,desc)
end
