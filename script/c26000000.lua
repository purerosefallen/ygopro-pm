--Pokémon Rules
--Not fully implemented: Cannot change turn counter to 1 during sudden death
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--apply
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATIONS_ALL)
	e1:SetCountLimit(1,sid+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(scard.condition)
	e1:SetOperation(scard.operation)
	c:RegisterEffect(e1)
	--remove type
	pm.EnableRemoveType(c,PM_TYPE_RULE)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e2:SetDescription(aux.Stringid(sid,3))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetRange(PM_LOCATION_RULES)
	e2:SetCountLimit(1)
	e2:SetCondition(scard.drcon)
	e2:SetOperation(scard.drop)
	c:RegisterEffect(e2)
	--update hp
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(PM_EFFECT_UPDATE_HP)
	e3:SetRange(PM_LOCATION_RULES)
	e3:SetTargetRange(PM_LOCATION_IN_PLAY,0)
	e3:SetValue(scard.hpval)
	c:RegisterEffect(e3)
	--knock out
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(PM_LOCATION_RULES)
	e4:SetCondition(scard.kocon)
	e4:SetOperation(scard.koop)
	c:RegisterEffect(e4)
	--promote
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e5:SetDescription(aux.Stringid(sid,4))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(PM_EVENT_LEAVE_PLAY)
	e5:SetRange(PM_LOCATION_RULES)
	e5:SetCondition(scard.prcon1)
	e5:SetOperation(scard.prop1)
	c:RegisterEffect(e5)
	--take prize
	local e6=e5:Clone()
	e6:SetDescription(aux.Stringid(sid,5))
	e6:SetCondition(scard.prcon2)
	e6:SetOperation(scard.prop2)
	c:RegisterEffect(e6)
	--prize check
	local e7=Effect.CreateEffect(c)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_ADJUST)
	e7:SetRange(PM_LOCATION_RULES)
	e7:SetCondition(scard.lpcon)
	e7:SetOperation(scard.lpop)
	c:RegisterEffect(e7)
	--limit evolve
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(PM_EFFECT_CANNOT_PLAY)
	e8:SetRange(PM_LOCATION_RULES)
	e8:SetTargetRange(1,0)
	e8:SetValue(scard.evolimit)
	c:RegisterEffect(e8)
	--limit supporter
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_CHAINING)
	e9:SetRange(PM_LOCATION_RULES)
	e9:SetOperation(scard.supreg)
	c:RegisterEffect(e9)
	local e10=e9:Clone()
	e10:SetCode(EVENT_CHAIN_NEGATED)
	e10:SetOperation(scard.supreset)
	c:RegisterEffect(e10)
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(PM_EFFECT_CANNOT_PLAY)
	e11:SetRange(PM_LOCATION_RULES)
	e11:SetTargetRange(1,0)
	e11:SetCondition(scard.supcon)
	e11:SetValue(scard.suplimit)
	c:RegisterEffect(e11)
	--limit stadium
	local e12=Effect.CreateEffect(c)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAINING)
	e12:SetRange(PM_LOCATION_RULES)
	e12:SetOperation(scard.stadreg)
	c:RegisterEffect(e12)
	local e13=e12:Clone()
	e13:SetCode(EVENT_CHAIN_NEGATED)
	e13:SetOperation(scard.stadreset)
	c:RegisterEffect(e13)
	local e14=Effect.CreateEffect(c)
	e14:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e14:SetType(EFFECT_TYPE_FIELD)
	e14:SetCode(PM_EFFECT_CANNOT_PLAY)
	e14:SetRange(PM_LOCATION_RULES)
	e14:SetTargetRange(1,0)
	e14:SetCondition(scard.stadcon)
	e14:SetValue(scard.stadlimit)
	c:RegisterEffect(e14)
	--limit energy
	local e15=Effect.CreateEffect(c)
	e15:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e15:SetCode(EVENT_CHAINING)
	e15:SetRange(PM_LOCATION_RULES)
	e15:SetOperation(scard.enerreg)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EVENT_CHAIN_NEGATED)
	e16:SetOperation(scard.enerreset)
	c:RegisterEffect(e16)
	local e17=Effect.CreateEffect(c)
	e17:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e17:SetType(EFFECT_TYPE_FIELD)
	e17:SetCode(PM_EFFECT_CANNOT_PLAY)
	e17:SetRange(PM_LOCATION_RULES)
	e17:SetTargetRange(1,0)
	e17:SetCondition(scard.enercon)
	e17:SetValue(scard.enerlimit)
	c:RegisterEffect(e17)
	--end turn
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(sid,6))
	e18:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e18:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e18:SetCode(PM_EVENT_ATTACK_END)
	e18:SetRange(PM_LOCATION_RULES)
	e18:SetCondition(scard.endcon1)
	e18:SetOperation(scard.endop)
	c:RegisterEffect(e18)
	local e19=e18:Clone()
	e19:SetDescription(aux.Stringid(sid,7))
	e19:SetCode(PM_EVENT_PLAY_SUCCESS)
	e19:SetCondition(scard.endcon2)
	c:RegisterEffect(e19)
	--win
	local e20=Effect.CreateEffect(c)
	e20:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
	e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e20:SetCode(PM_EVENT_KNOCKED_OUT)
	e20:SetRange(PM_LOCATION_RULES)
	e20:SetCondition(scard.wincon)
	e20:SetOperation(scard.winop)
	c:RegisterEffect(e20)
	--cannot bp
	pm.EnableCannotBP(c)
	--infinite hand
	pm.EnableInfiniteHand(c)
	--cannot change position
	pm.EnableCannotChangePosition(c)
	--cannot attack
	pm.EnableCannotAttack(c)
	--cannot direct attack
	pm.EnableCannotDirectAttack(c)
	--indestructible
	pm.EnableIndestructible(c,EFFECT_INDESTRUCTABLE_BATTLE)
	--no battle damage
	pm.EnableNoBattleDamage(c)
	--no effect damage
	pm.EnableNoEffectDamage(c)
	--cannot summon/mset
	pm.EnableCannotSummonMSet(c)
	--cannot sset
	pm.EnableCannotSSet(c)
	--protect
	pm.EnableProtection(c)
end
scard.pokemon_card=true
--apply
function scard.filter(c)
	return not c.pokemon_card
end
function scard.condition(e)
	local tp=e:GetHandlerPlayer()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,0,LOCATIONS_ALL,1,nil,sid) then
		return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()==1
	else
		return Duel.GetTurnCount()==1
	end
end
function scard.operation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local c=e:GetHandler()
	--apply rules for you
	Duel.Remove(c,POS_FACEUP,REASON_RULE)
	Duel.SendtoExtraP(c,tp,REASON_RULE)
	--apply rules for your opponent
	local rg=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATIONS_ALL,nil,sid)
	if rg:GetCount()>0 then
		Duel.Remove(rg:GetFirst(),POS_FACEUP,REASON_RULE)
		Duel.SendtoExtraP(rg:GetFirst(),1-tp,REASON_RULE)
	else
		local rules=Duel.CreateToken(1-tp,sid)
		Duel.Remove(rules,POS_FACEUP,REASON_RULE)
		Duel.SendtoExtraP(rules,1-tp,REASON_RULE)
	end
	if turnp==1-tp then return end
	--check for non-pokémon tcg cards
	local g1=Duel.GetMatchingGroup(scard.filter,tp,LOCATIONS_ALL,0,nil)
	local g2=Duel.GetMatchingGroup(scard.filter,tp,0,LOCATIONS_ALL,nil)
	--check for basic pokémon
	local g3=Duel.GetMatchingGroup(Card.IsBasicPokemon,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local g4=Duel.GetMatchingGroup(Card.IsBasicPokemon,tp,0,LOCATION_HAND+LOCATION_DECK,nil)
	--check for restricted cards
	local g5=Duel.GetMatchingGroup(Card.IsHasDeckRestriction,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local g6=Duel.GetMatchingGroup(Card.IsHasDeckRestriction,tp,0,LOCATION_HAND+LOCATION_DECK,nil)
	--check deck size
	local dg1=Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local dg2=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND+LOCATION_DECK,nil)
	--create group for sudden death
	dg1:Merge(dg2)
	local dc=dg1:GetFirst()
	for dc in aux.Next(dg1) do
		dc:RegisterFlagEffect(PM_EFFECT_SUDDEN_DEATH_CHECK,0,0,0)
	end
	if (g1:GetCount()>0 and g2:GetCount()>0) or (g3:GetCount()==0 and g4:GetCount()==0)
		or (g5:GetCount()>1 and g6:GetCount()>1) or (dg1:GetCount()~=60 and dg2:GetCount()~=60) then
		Duel.Win(1-tp,PM_WIN_REASON_INVALID)
		Duel.Win(tp,PM_WIN_REASON_INVALID)
		return
	elseif g1:GetCount()>0 or g3:GetCount()==0 or g5:GetCount()>1 or dg1:GetCount()~=60 then
		Duel.Win(1-tp,PM_WIN_REASON_INVALID)
		return
	elseif g2:GetCount()>0 or g4:GetCount()==0 or g6:GetCount()>1 or dg2:GetCount()~=60 then
		Duel.Win(tp,PM_WIN_REASON_INVALID)
		return
	end
	--draw starting hand
	scard.draw_starting_hand(e,tp,tp)
	scard.draw_starting_hand(e,tp,1-tp)
	--check for a basic pokémon
	scard.basic_pokemon_check(e,tp,tp)
	scard.basic_pokemon_check(e,tp,1-tp)
	--play benched pokémon
	scard.play_bench_pokemon(e,tp,tp)
	scard.play_bench_pokemon(e,tp,1-tp)
	--set prize cards
	scard.set_prize_cards(e,tp,tp,6)
	scard.set_prize_cards(e,tp,1-tp,6)
	--flip
	scard.flip(e,tp)
	--draw extra
	scard.draw_extra(e,tp,tp)
	scard.draw_extra(e,tp,1-tp)
end
function scard.draw_starting_hand(e,tp,player)
	local ft=Duel.GetFieldGroupCount(player,LOCATION_HAND,0)
	if ft==7 then return end
	Duel.Draw(player,7-ft,REASON_RULE)
end
function scard.play_active_pokemon(e,tp,player)
	if Duel.GetLocationCount(player,PM_LOCATION_ACTIVE)<=0
		or not Duel.CheckLocation(player,PM_LOCATION_ACTIVE,SEQUENCE_EXTRA_MZONE) then return end
	Duel.Hint(HINT_SELECTMSG,player,PM_HINTMSG_ACTIVE)
	local g=Duel.SelectMatchingCard(player,Card.IsBasicPokemon,player,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.MoveToField(tc,tp,player,PM_LOCATION_ACTIVE,PM_POS_FACEDOWN_UPSIDE,true)
	if not tc:IsActive() then Duel.MoveSequence(tc,SEQUENCE_EXTRA_MZONE) end
end
function scard.basic_pokemon_check(e,tp,player)
	local confp=1-tp
	if player==1-tp then confp=tp end
	local g=Duel.GetMatchingGroup(Card.IsBasicPokemon,player,LOCATION_HAND,0,nil)
	local dcount=0
	if g:GetCount()==0 then
		repeat
			local hg=Duel.GetFieldGroup(player,LOCATION_HAND,0)
			Duel.ConfirmCards(confp,hg)
			Duel.SendtoDeck(hg,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_RULE)
			Duel.ShuffleDeck(player)
			Duel.BreakEffect()
			Duel.Draw(player,7,REASON_RULE)
			dcount=dcount+1
		until Duel.IsExistingMatchingCard(Card.IsBasicPokemon,player,LOCATION_HAND,0,1,nil)
		Duel.RegisterFlagEffect(player,PM_EFFECT_MULLIGAN_CHECK,RESET_PHASE+PHASE_END,0,1)
		e:SetLabel(dcount)
	end
	scard.play_active_pokemon(e,tp,player)
end
function scard.play_bench_pokemon(e,tp,player)
	local ft=Duel.GetLocationCount(player,PM_LOCATION_BENCH)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(Card.IsBasicPokemon,player,LOCATION_HAND,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(player,aux.Stringid(sid,0)) then return end
	Duel.Hint(HINT_SELECTMSG,player,aux.Stringid(sid,1))
	local sg=g:Select(player,1,ft,nil)
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		Duel.MoveToField(tc,tp,player,PM_LOCATION_BENCH,PM_POS_FACEDOWN_UPSIDE,true)
	end
end
function scard.set_prize_cards(e,tp,player,count)
	local g=Duel.GetDecktopGroup(player,count)
	if g:GetCount()==0 then return end
	Duel.DisableShuffleCheck()
	Duel.SetPrizeCard(g,POS_FACEDOWN,REASON_RULE)
	local ct=Duel.GetPrizeGroupCount(tp,player)
	Duel.SetLP(1-player,ct)
end
function scard.flip(e,tp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	Duel.ChangePosition(g,PM_POS_FACEUP_UPSIDE)
end
function scard.draw_extra(e,tp,player)
	local mp=tp
	if player==tp then mp=1-tp end
	if Duel.GetFlagEffect(mp,PM_EFFECT_MULLIGAN_CHECK)==0 then return end
	local dcount=e:GetLabel()
	if dcount==0 or not Duel.SelectYesNo(player,aux.Stringid(sid,2)) then return end
	repeat
		Duel.Draw(player,1,REASON_RULE)
		dcount=dcount-1
	until dcount==0 or not (Duel.IsPlayerCanDraw(player,1) and Duel.SelectYesNo(player,aux.Stringid(sid,2)))
end
--draw
function scard.drcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and Duel.GetTurnCount()==1
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_RULE)
end
--update hp
function scard.hpval(e,c)
	return c:GetCounter(PM_DAMAGE_COUNTER)*-10
end
--knock out
function scard.kofilter(c)
	return c:IsFaceup() and c:GetHP()==0
end
function scard.kocon(e)
	return Duel.IsExistingMatchingCard(scard.kofilter,e:GetHandlerPlayer(),PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,1,nil)
end
function scard.koop(e)
	local g=Duel.GetMatchingGroup(scard.kofilter,e:GetHandlerPlayer(),PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	Duel.KnockOut(g,REASON_RULE)
end
--promote
function scard.prfilter1(c,tp)
	return c:IsPokemon() and c:IsPreviousLocation(PM_LOCATION_ACTIVE)
		and c:GetPreviousSequence()==SEQUENCE_EXTRA_MZONE and c:GetOwner()==tp
end
function scard.prcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.prfilter1,1,nil,tp)
		and Duel.GetLocationCount(tp,PM_LOCATION_ACTIVE)>0
		and Duel.CheckLocation(tp,PM_LOCATION_ACTIVE,SEQUENCE_EXTRA_MZONE)
		and Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,PM_LOCATION_BENCH,0,1,nil)
end
function scard.prop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PROMOTE)
	local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,PM_LOCATION_BENCH,0,1,1,nil)
	Duel.HintSelection(g)
	Duel.MoveSequence(g:GetFirst(),SEQUENCE_EXTRA_MZONE)
end
--take prize
function scard.prfilter2(c,tp)
	return c:IsPokemon() and c:IsPreviousLocation(PM_LOCATION_IN_PLAY) and c:GetOwner()==1-tp
end
function scard.thfilter(c)
	return c:IsPrize() and c:IsAbleToHand()
end
function scard.prcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.prfilter2,1,nil,tp)
		and Duel.IsExistingMatchingCard(scard.thfilter,tp,PM_LOCATION_PRIZE,0,1,nil)
end
function scard.prop2(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local n=1
	if ec:IsPokemonEX() or ec:IsPokemonGX() then n=2 end
	local g1=Duel.GetPrizeGroup(tp,tp):Filter(scard.thfilter,nil)
	local g2=Duel.GetPrizeGroup(tp,1-tp):Filter(scard.thfilter,nil)
	local rg=g1:RandomSelect(tp,n)
	Duel.SendtoHand(rg,PLAYER_OWNER,REASON_RULE)
	Duel.RegisterFlagEffect(tp,PM_EFFECT_PRIZE_CARD_CHECK,0,0,0)
end
function scard.sdfilter(c)
	return c:GetFlagEffect(PM_EFFECT_SUDDEN_DEATH_CHECK)~=0
end
function scard.rmfilter(c)
	return c:GetFlagEffect(PM_EFFECT_SUDDEN_DEATH_CHECK)==0
end
function scard.sudden_death(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local loc=LOCATIONS_ALL-LOCATION_DECK-PM_LOCATION_RULES
	local g=Duel.GetFieldGroup(tp,loc,loc)
	local sg=g:Filter(scard.sdfilter,nil)
	local rg=g:Filter(scard.rmfilter,nil)
	--reset game
	Duel.Hint(HINT_OPSELECTED,1-turnp,PM_DESC_SUDDEN_DEATH)
	--Duel.SendtoDeck(rg,PLAYER_OWNER,DECK_ORDER_UNEXIST,REASON_RULE)
	Duel.SendtoDeck(sg,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	--call the coin flip
	local opt=Duel.SelectOption(1-turnp,SELECT_HEADS,SELECT_TAILS)
	local res=Duel.TossCoin(turnp,1)
	local skipp=1-turnp
	if turnp==1-turnp and opt==res then skipp=turnp
	elseif turnp==turnp and opt==res then skipp=1-turnp end
	--skip to draw phase
	Duel.SkipPhase(skipp,PHASE_MAIN1,RESET_PHASE+PHASE_DRAW,1)
	Duel.RegisterFlagEffect(turnp,PM_EFFECT_SUDDEN_DEATH_RESTART,RESET_PHASE+PHASE_END,0,1)
	--draw starting hand
	scard.draw_starting_hand(e,tp,turnp)
	scard.draw_starting_hand(e,tp,1-turnp)
	--check for a basic pokémon
	scard.basic_pokemon_check(e,tp,turnp)
	scard.basic_pokemon_check(e,tp,1-turnp)
	--play benched pokémon
	scard.play_bench_pokemon(e,tp,turnp)
	scard.play_bench_pokemon(e,tp,1-turnp)
	--set prize cards
	scard.set_prize_cards(e,tp,turnp,1)
	scard.set_prize_cards(e,tp,1-turnp,1)
	--flip
	scard.flip(e,turnp)
	--draw extra
	scard.draw_extra(e,tp,turnp)
	scard.draw_extra(e,tp,1-turnp)
	--start turn
	Duel.Draw(turnp,1,REASON_RULE)
end
--prize check
function scard.lpcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),PM_EFFECT_PRIZE_CARD_CHECK)~=0
end
function scard.lpop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetPrizeGroupCount(tp,tp)
	local ct2=Duel.GetPrizeGroupCount(tp,1-tp)
	if ct1==0 and ct2==0 then
		ct1=1
		scard.sudden_death(e,tp,eg,ep,ev,re,r,rp)
	end
	Duel.SetLP(1-tp,ct1)
	Duel.Readjust()
	Duel.ResetFlagEffect(tp,PM_EFFECT_PRIZE_CARD_CHECK)
end
--limit evolve
function scard.evolimit(e,re,tp)
	local rc=re:GetHandler()
	return Duel.IsFirstTurn() and (rc:IsEvolution() or rc:IsPokemonLVX())
end
--limit supporter
function scard.supreg(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsSupporter() then return end
	e:GetHandler():RegisterFlagEffect(PM_EFFECT_LIMIT_SUPPORTER,RESET_EVENT+RESETS_STANDARD_DISCONTROL+RESET_PHASE+PHASE_END,0,1)
end
function scard.supreset(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsSupporter() then return end
	e:GetHandler():ResetFlagEffect(PM_EFFECT_LIMIT_SUPPORTER)
end
function scard.supcon(e)
	return e:GetHandler():GetFlagEffect(PM_EFFECT_LIMIT_SUPPORTER)~=0
end
function scard.suplimit(e,te,tp)
	return te:GetHandler():IsSupporter()
end
--limit stadium
function scard.stadreg(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsStadium() then return end
	e:GetHandler():RegisterFlagEffect(PM_EFFECT_LIMIT_STADIUM,RESET_EVENT+RESETS_STANDARD_DISCONTROL+RESET_PHASE+PHASE_END,0,1)
end
function scard.stadreset(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsStadium() then return end
	e:GetHandler():ResetFlagEffect(PM_EFFECT_LIMIT_STADIUM)
end
function scard.stadcon(e)
	return e:GetHandler():GetFlagEffect(PM_EFFECT_LIMIT_STADIUM)~=0
end
function scard.stadlimit(e,te,tp)
	return te:GetHandler():IsStadium()
end
--limit energy
function scard.enerreg(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsEnergy() then return end
	e:GetHandler():RegisterFlagEffect(PM_EFFECT_LIMIT_ENERGY,RESET_EVENT+RESETS_STANDARD_DISCONTROL+RESET_PHASE+PHASE_END,0,1)
end
function scard.enerreset(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or not re:GetHandler():IsEnergy() then return end
	e:GetHandler():ResetFlagEffect(PM_EFFECT_LIMIT_ENERGY)
end
function scard.enercon(e)
	return e:GetHandler():GetFlagEffect(PM_EFFECT_LIMIT_ENERGY)~=0
end
function scard.enerlimit(e,te,tp)
	return te:GetHandler():IsEnergy()
end
--end turn
function scard.endcon1(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return rc:IsActive() and rc:IsControler(tp) and loc==PM_LOCATION_ACTIVE
		and re:IsHasProperty(PM_EFFECT_FLAG_POKEMON_ATTACK)
end
function scard.endfilter(c,tp)
	return c:IsMegaEvolution() and c:IsSummonType(PM_SUMMON_TYPE_EVOLVE) and c:IsControler(tp)
end
function scard.endcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.endfilter,1,nil,tp)
end
function scard.endop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
--win
function scard.wincon(e)
	return Duel.GetMatchingGroupCount(Card.IsPokemon,e:GetHandlerPlayer(),PM_LOCATION_IN_PLAY,0,nil)==0
end
function scard.winop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(1-tp,PM_WIN_REASON_KNOCKOUT)
end
