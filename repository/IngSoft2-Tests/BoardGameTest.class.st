Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#instVars : [
		'anotherSpeedCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardGameTest >> assert: groupOfEvents areDistributedBasedOn: distributionOfEvents withTolerance: tolerance [
	| val |
	distributionOfEvents do:[ :probabilityEvent | val:=(self relativeEventOcurrenceOf: probabilityEvent in:groupOfEvents).self assert: val < tolerance] 
]

{ #category : #positionTests }
BoardGameTest >> creationOfAnotherBoardGameWithThreePlayers [
	| secondDice firstDice thirdDice |
	firstDice := DeterministicDice with: #(12 20 21 17).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	^ self
		creationOfBoardGameWithThatUsesA: firstDice
		a: secondDice
		andA: thirdDice
]

{ #category : #positionTests }
BoardGameTest >> creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice [
	| aGroupOfDices aDiceCup aSpinNumber aNumberOfFields aBoardGame aGroupOfPlayers fields aDeck |
	aGroupOfPlayers := {#pau . #male . #belu}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #positionTests }
BoardGameTest >> creationOfBoardGameWithThreePlayers [
	|secondDice firstDice thirdDice |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	^ self
		creationOfBoardGameWithThatUsesA: firstDice
		a: secondDice
		andA: thirdDice
]

{ #category : #playingWithCardsTests }
BoardGameTest >> generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults [
	| aDeck aGroupOfDices aDiceCup fields aNumberOfFields aDice aBoardGame aSpinNumber |
	aDice := DeterministicDice with: aSequenceOfDiceResults.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber := 5.
	fields := self generateManuallyIncludingCardDealer: aNumberOfFields.
	aDeck := DeterministicDeck containing: cards.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		and: aDeck
		onABoardWith: fields
		wonWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #fieldsEffectTests }
BoardGameTest >> generateDeck [
	| cards aDeck |
	cards := OrderedCollection newFrom: { Cancellation new . Acceleration new . Speed new . DoOver new . Repetition new . Overload new}.
	aDeck := Deck containing: cards.
	^aDeck.
]

{ #category : #fieldsEffectTests }
BoardGameTest >> generateManually: aNumberOfFields [ 
	|  fields  effectDistributionFields effectToDistribute |
	fields:= OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	effectToDistribute := {WormHole new. SpeedUp new.AtomicBomb new.MoonWalk with: 16. MoonWalk with: 11 }.
	effectDistributionFields := {{3 . 17}.{30 . 48}.{44}.{32}.{23}}.
	effectToDistribute with: effectDistributionFields do:[ :effect :effectFields | 
						effectFields do: 
								[ :fieldNumber | fields at: fieldNumber put: effect ]].
	^fields.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> generateManuallyIncludingCardDealer: aNumberOfFields [ 
	|  fields effectDistributionFields effectToDistribute |
	fields:= OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	effectToDistribute := {WormHole new. SpeedUp new.AtomicBomb new.MoonWalk with: 16. MoonWalk with: 11. CardDealer new}.
	effectDistributionFields := {{3 . 17}.{30 . 48}.{44}.{32}.{23}.{10}}.
	effectToDistribute with: effectDistributionFields do:[ :effect :effectFields | 
						effectFields do: 
								[ :fieldNumber | fields at: fieldNumber put: effect ]].
	^fields.
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithASinglePlayerAndASingleRound [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber fields aDeck |
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {#pau}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber fields aDeck |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {#pau . #male . #belu . #juli}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
		
	^ aBoardGame
]

{ #category : #asserting }
BoardGameTest >> relativeEventOcurrenceOf: aProbabilityEvent in: groupOfEvents [ 
	| numberOfOcurrences percentageOfOcurrences relativePercentageOfOCurrences |
	numberOfOcurrences:= groupOfEvents count: [ :event | event = (aProbabilityEvent event)].
	percentageOfOcurrences := numberOfOcurrences / (groupOfEvents size).
	relativePercentageOfOCurrences := (percentageOfOcurrences - (aProbabilityEvent probability ))abs.
	^relativePercentageOfOCurrences*100.
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
	| aBoardGame pauPosition beluPosition juliPosition malePosition|
	aBoardGame := self newBoardGameWithMultiplePlayers.
	pauPosition := Tracker of: #pau standingOn: 21 after: 1.
	beluPosition := Tracker of: #belu standingOn: 14 after: 1.
	juliPosition := Tracker of: #juli standingOn: 13 after: 1.
	malePosition := Tracker of: #male standingOn: 11 after: 1.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition . juliPosition . malePosition }).
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has not finished yet, so it does not have a winner.' ].
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAFinalRanking [
	| aBoardGame pauPosition beluPosition malePosition|
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	pauPosition := Tracker of: #pau standingOn: 46 after: 1.
	beluPosition := Tracker of: #belu standingOn: 13 after: 1.
	malePosition := Tracker of: #male standingOn: 21 after: 1.
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . malePosition . beluPosition})
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasARanking [
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pauPosition := Tracker of: #pau standingOn: 61 after: 1.
	1 to: 18 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAWinner [
	| aBoardGame |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	1 to: 16 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame winner 
		equals: #pau.
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAlreayFinishedSoNoOneCanContinuePlaying [
	| aBoardGame |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	1 to: 16 do: [ :n | aBoardGame nextTurn ].
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has already finished, contestants can not play anymore.' ].
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameHasFinished [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame isFinished).
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameHasFinishedAndHasAWinner [
	| aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber fields aDeck |
	aDice := DeterministicDice with: #(20 15 26 37).
	aGroupOfPlayers := {#pau. #jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 54.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=3.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 1.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self deny: aBoardGame isFinished.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 21.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 1.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 21.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 16.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 47.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 16.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 47.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 53.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 1.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 13.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 53.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 2.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 13.
	self assert: ((aBoardGame positionOf: #jorge)field) equals: 14.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 2.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 39.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 14.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 2.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 39.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 51.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 2.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 5.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 51.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 3.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 5.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 12.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 3.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 31.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 12.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 3.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 31.
	self assert: ((aBoardGame positionOf: #jorge)field) equals: 49.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 3.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame positionOf: #pau) field) equals: 51.
	self assert: ((aBoardGame positionOf: #jorge) field) equals: 49.
	self assert: ((aBoardGame positionOf: #pau) round) equals: 3.
	self assert: ((aBoardGame positionOf: #jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: aBoardGame winner equals: #jorge.
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameHasFinishedAndPlayersMustBeHalted [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has already finished, contestants can not play anymore.' ].
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersThatChangePositionOvertime [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Tracker of: #pau standingOn: 31 after: 1.
	beluPosition := Tracker of: #belu standingOn: 14 after: 1.
	malePosition := Tracker of: #male standingOn: 13 after: 1.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					({pauPosition . beluPosition . malePosition})).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersThatChangeRoundNumberOvertime [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	pauPosition := Tracker of: #pau standingOn: 33 after: 2.
	beluPosition := Tracker of: #belu standingOn: 10 after: 2.
	malePosition := Tracker of: #male standingOn: 43 after: 1.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . beluPosition . malePosition })
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersWithAnInitialPosition [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
	malePosition := Tracker of: #male standingOn: 1 after: 1.

	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: {pauPosition . malePosition . beluPosition }).

	
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameIsInProcess [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	
	self deny: (aBoardGame isFinished).
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameKnowsThePlayersInitialPosition [
 		
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	
	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pauPosition := Tracker of: #pau standingOn: 5 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	|  aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber pauPosition fields aDeck |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {#pau}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
	pauPosition := Tracker of: #pau standingOn: 25 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).

]

{ #category : #validationTests }
BoardGameTest >> testABoardGameMustHaveAtLeastOneLap [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber aBoard fields aDeck |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {#pau . #male . #belu}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 49.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=0.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste one lap'].
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameNeedsAtLeastOnePlayer [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber aBoard fields aDeck |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 49.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aDeck := self generateDeck.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste ONE player'].
]

{ #category : #validationTests }
BoardGameTest >> testABoardMustAtLeastTwoFields [
 		
	| fields eventManager speedUpEvent eventsDistribution|
	speedUpEvent:= ProbabilityEvent with: 1.0 of: SpeedUp new.
	eventsDistribution := OrderedCollection newFrom: {speedUpEvent}.
	eventManager := RandomProbabilityEventManager basedOn: eventsDistribution.
	fields := eventManager generate: 1.

	self 
		should:[Board has: fields.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'There must be al least two fields'].
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testACancellationCardCanAlsoBeUsedByAPlayerIfItIsNotHisTurn [
	| aBoardGame aGroupOfPlayers speedCard cancellationCard aSequenceOfDiceResults cards anotherCancellationCard overloadCard |
	speedCard := Speed new.
	cancellationCard := Cancellation new.
	anotherSpeedCard := Speed new.
	anotherCancellationCard := Cancellation new.
	overloadCard:= Overload new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := {speedCard.cancellationCard.anotherSpeedCard.anotherCancellationCard.overloadCard}.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.
	
	aBoardGame affect: #belu using: speedCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame affect: speedCard using: cancellationCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self
		assert: (aBoardGame influentialCardsOf: #belu)
		isEmpty.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testACardDealearGivesAPlayerACard [
	|aBoardGame aGroupOfPlayers repeatCard aSequenceOfDiceResults cards speedCard aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |	
	speedCard:= Speed new.
	repeatCard := Repetition new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard := Repetition new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { speedCard . repeatCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
		
	self assert: (aBoardGame cardsInHandOf: #pau) equals: (OrderedCollection newFrom: { speedCard . repeatCard }).
	aBoardGame nextTurn.	
	self assert: (aBoardGame cardsInHandOf: #pau) equals: (OrderedCollection newFrom: { speedCard . repeatCard  . aThirdSpeedCard}).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testACardDealearGivesAPlayerACardAndHeUsesItInmediately [
	|aBoardGame aGroupOfPlayers repeatCard aSequenceOfDiceResults cards speedCard aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |	
	speedCard:= Speed new.
	repeatCard := Repetition new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard := Repetition new.
	cards := { speedCard . repeatCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
		
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: #pau using: speedCard by: #pau.
		
	self assert: (aBoardGame influentialCardsOf: #pau) equals: (OrderedCollection newFrom: { speedCard }).
	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasNoEffect [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Tracker of: #pau standingOn: 31 after: 1.
	beluPosition := Tracker of: #belu standingOn: 14 after: 1.
	malePosition := Tracker of: #male standingOn: 11 after: 1.
	1 to: 4 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . beluPosition . malePosition}).

]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseACardHeDoesNotHave [
	| aBoardGame aGroupOfPlayers overloadCard aSequenceOfDiceResults cards speedCard repeatCard aSecondSpeedCard |
	overloadCard := Overload new.
	speedCard:= Speed new.
	repeatCard := Repetition new.
	aSecondSpeedCard:= Speed new.
	cards := { overloadCard . speedCard . repeatCard . aSecondSpeedCard }.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(10 10 7 3).
	cards := {Acceleration new . Cancellation  new . DoOver new . Speed new . Repetition new}.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.	
	
	self 
		should:[aBoardGame affect: #pau using: overloadCard by: #pau] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A player must have a card in hand in order to use it' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseADoOverCardWhenTheLastCardPlayedHadASpeedEffectOutsideHisTurn [
	| aBoardGame aGroupOfPlayers  speedCard doOverCard aSequenceOfDiceResults cards anotherDoOverCard overloadCard |
	speedCard := Speed new.
	doOverCard := DoOver new.
	anotherSpeedCard := Speed new.
	anotherDoOverCard:= DoOver new.
	overloadCard:= Overload new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { speedCard . doOverCard . anotherSpeedCard . anotherDoOverCard . overloadCard }.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	aBoardGame nextTurn.
	aBoardGame affect: #pau using: anotherSpeedCard by: #belu.
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame affect: #pau using: anotherDoOverCard by: #belu] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseASpeedUpCardIfItIsNotHisTurn [
	| aBoardGame aGroupOfPlayers speedCard cards aSequenceOfDiceResults doOverCard anotherDoOverCard overloadCard |
	aSequenceOfDiceResults := #(9 10 7 3).
	speedCard:= Speed new.
	doOverCard := DoOver new.
	anotherSpeedCard := Speed new.
	anotherDoOverCard:= DoOver new.
	overloadCard:= Overload new.
	cards :={speedCard . doOverCard . anotherSpeedCard .anotherDoOverCard . overloadCard}.
	aGroupOfPlayers := {#pau . #belu}.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.
	aBoardGame nextTurn.

	self 
		should:[aBoardGame affect: #pau using: speedCard by: #pau] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHas2CardsAtTheBegginingOfTheGame [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	self assert: (aBoardGame cardsInHandOf: #pau) size equals: 2.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHasThreeCardsAfterLandingOnAFieldWithACardDealerEffect [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber fields aDeck |
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	self assert: (aBoardGame cardsInHandOf: #pau) size equals: 3.
]

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: #pau.	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerThrowsACardAndItIsNoLongerInHand [
	|aBoardGame aGroupOfPlayers repeatCard aSequenceOfDiceResults cards speedCard aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |	
	speedCard:= Speed new.
	repeatCard := Repetition new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard := Repetition new.
	cards := { speedCard . repeatCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
		
	self assert: (aBoardGame cardsInHandOf: #pau) equals: (OrderedCollection newFrom: { speedCard . repeatCard }).
	aBoardGame affect: #pau using: speedCard by: #pau.	
	self assert: (aBoardGame cardsInHandOf: #pau) equals: (OrderedCollection newFrom: { repeatCard }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesASpeedCard [
	| aBoardGame aGroupOfPlayers speedCard cancellationCard aSequenceOfDiceResults cards anotherCancellationCard aThirdSpeedCard |
	speedCard := Speed new.
	cancellationCard := Cancellation new.
	anotherSpeedCard := Speed new.
	anotherCancellationCard := Cancellation new.
	aThirdSpeedCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { speedCard . cancellationCard . anotherSpeedCard . anotherCancellationCard . aThirdSpeedCard}.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	aBoardGame affect: #pau using: speedCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: speedCard using: anotherCancellationCard by: #belu.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame influentialCardsOf: #belu)  equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesAnAccelerationCard [
	| aBoardGame aGroupOfPlayers cancellationCard accelerationCard aSequenceOfDiceResults cards anotherAccelerationCard anotherCancellationCard aThirdAccelerationCard |
	accelerationCard := Acceleration new.
	cancellationCard := Cancellation new.
	anotherAccelerationCard := Acceleration new.
	anotherCancellationCard := Cancellation new.
	aThirdAccelerationCard := Acceleration new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { accelerationCard . cancellationCard . anotherAccelerationCard . anotherCancellationCard . aThirdAccelerationCard }.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	aBoardGame affect: #pau using: accelerationCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: accelerationCard using: cancellationCard by: #pau.
	aBoardGame nextTurn.
	self assert: (aBoardGame influentialCardsOf: #belu) equals: (OrderedCollection new).
	self assert: (aBoardGame influentialCardsOf: #pau) equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aBoardGame aGroupOfPlayers doOverCard  pauPosition beluPosition speedCard aSequenceOfDiceResults cards anotherDoOverCard aThirdSpeedCard |	
	speedCard := Speed new.
	doOverCard := DoOver new.
	anotherSpeedCard := Speed new.
	anotherDoOverCard := DoOver new.
	aThirdSpeedCard := Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { speedCard . doOverCard . anotherSpeedCard . anotherDoOverCard . aThirdSpeedCard }.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau  standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.

	aBoardGame affect: #pau using: doOverCard by: #pau.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadASpeedEffect [
	|aBoardGame aGroupOfPlayers doOverCard pauPosition beluPosition speedCard aSequenceOfDiceResults cards accelerarionCard repetitionCard overloadCard |
	speedCard:= Speed new.
	doOverCard := DoOver new.
	accelerarionCard := Acceleration new.
	repetitionCard := Repetition new.
	overloadCard:= Overload new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { doOverCard . speedCard . accelerarionCard . repetitionCard . overloadCard }.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 19 after: 1.
	beluPosition := Tracker of: #belu standingOn: 11 after: 1.

	aBoardGame affect: #pau using: speedCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: #belu using: doOverCard by: #pau.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadAnAccelerationEffect [
	|aBoardGame aGroupOfPlayers doOverCard pauPosition beluPosition accelerationCard aSequenceOfDiceResults cards speedCard repetitionCard overloadCard |
	accelerationCard := Acceleration new.
	doOverCard := DoOver new.
	speedCard := Speed new.
	repetitionCard := Repetition new.
	overloadCard:= Overload new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { doOverCard . accelerationCard . speedCard . overloadCard . repetitionCard }.
	
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 20 after: 1.
	beluPosition := Tracker of: #belu standingOn: 12 after: 1.
		
	aBoardGame affect: #pau using: accelerationCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: #pau using: doOverCard by: #pau.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasACancellationCard [
	|aBoardGame aGroupOfPlayers doOverCard cancellationCard speedCard aSequenceOfDiceResults cards aSecondSpeedCard aSecondDoOverCard aThirdSpeedCard aThirdDoOverCard aSecondCancellationCard aThirdCancellationCard |
	cancellationCard := Cancellation new.
	speedCard:= Speed new.
	doOverCard := DoOver new.
	aSecondCancellationCard:= Cancellation new.
	aSecondSpeedCard:= Speed new.
	aSecondDoOverCard := DoOver new.
	aThirdCancellationCard := Cancellation new.
	aThirdSpeedCard:= Speed new.
	aThirdDoOverCard := DoOver new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := {cancellationCard . speedCard . doOverCard . aSecondCancellationCard . aSecondSpeedCard . aSecondDoOverCard . aThirdCancellationCard . aThirdDoOverCard . aThirdSpeedCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
	aBoardGame nextTurn.
	aBoardGame nextTurn.

	aBoardGame affect: #belu using: speedCard by: #pau.
	aBoardGame affect: #pau using: aSecondSpeedCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame affect: speedCard using: cancellationCard by: #pau.
	aBoardGame affect: aSecondSpeedCard using: doOverCard by: #belu.
	self assert:  (aBoardGame influentialCardsOf: #pau)  isEmpty.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasARepeatCard [
	|aBoardGame aGroupOfPlayers doOverCard pauPosition beluPosition repeatCard aSequenceOfDiceResults cards aSecondDoOverCard aSecondRepeatCard aThirdDoOverCard aThirdRepeatCard aFourthRepearCard |	
	doOverCard:= DoOver new.
	repeatCard := Repetition new.
	aSecondDoOverCard:= DoOver new.
	aSecondRepeatCard := Repetition new.
	aThirdDoOverCard:= DoOver new.
	aThirdRepeatCard := Repetition new.
	aFourthRepearCard := Repetition new.
	cards := { repeatCard . doOverCard . aSecondRepeatCard . aSecondDoOverCard . aThirdRepeatCard . aThirdDoOverCard . aFourthRepearCard }.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 13 after: 1.
	beluPosition := Tracker of: #belu standingOn: 10 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame affect: #pau using: aSecondRepeatCard by: #belu.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame affect: #belu using: doOverCard by: #pau.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenAtomicBombEffecttHasBeenAppliedLast [
	| aBoardGame aGroupOfPlayers repeatCard  pauPosition beluPosition speedCard malePosition aSequenceOfDiceResults cards aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |
	repeatCard := Repetition new.
	speedCard := Speed new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard := Repetition new.
	cards := { repeatCard . speedCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aGroupOfPlayers := {#pau . #belu . #male}.
	aSequenceOfDiceResults := #(60 10 1 44).
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
	pauPosition := Tracker of: #pau standingOn: 1 after: 2.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
	malePosition := Tracker of: #male standingOn: 1 after: 1.
			
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.

	aBoardGame affect: #pau using: repeatCard by: #pau.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition . malePosition  }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenMoonWalkEffecttHasBeenAppliedLast [
	|aBoardGame aGroupOfPlayers repeatCard pauPosition beluPosition speedCard malePosition  aSequenceOfDiceResults cards aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |
	repeatCard := Repetition new.
	speedCard := Speed new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard := Repetition new.
	cards := { repeatCard . speedCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aGroupOfPlayers := {#pau . #belu . #male}.
	aSequenceOfDiceResults := #(13 4 22).
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
	malePosition := Tracker of: #male standingOn: 12 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.

	aBoardGame affect: #belu using: aSecondRepeatCard by: #belu.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: { malePosition . pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aBoardGame aGroupOfPlayers repeatCard pauPosition beluPosition speedCard aSequenceOfDiceResults cards aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard |
	repeatCard := Repetition new.
	speedCard := Speed new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { repeatCard . speedCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
	
	aBoardGame affect: #belu using: aSecondRepeatCard by: #belu.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoEffectHasBeenAppliedLast [
	| aBoardGame aGroupOfPlayers repeatCard pauPosition beluPosition speedCard aSequenceOfDiceResults cards aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard aThirdRepeatCard |
	repeatCard := Repetition new.
	speedCard := Speed new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aThirdRepeatCard:= Repetition new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { repeatCard . speedCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard . aThirdRepeatCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 10 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
		
	aBoardGame nextTurn.

	aBoardGame affect: #belu using: aSecondRepeatCard by: #belu.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenSpeedEffecttHasBeenAppliedLast [
	| aBoardGame aGroupOfPlayers repeatCard pauPosition beluPosition speedCard aSequenceOfDiceResults cards aSecondSpeedCard aSecondRepeatCard aThirdSpeedCard |
	repeatCard := Repetition new.
	speedCard := Speed new.
	aSecondSpeedCard:= Speed new.
	aSecondRepeatCard := Repetition new.
	aThirdSpeedCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(29 10 1 10).
	cards := { repeatCard . speedCard . aSecondSpeedCard . aSecondRepeatCard . aThirdSpeedCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 38 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
		
	aBoardGame nextTurn.

	aBoardGame affect: #pau using: aSecondRepeatCard by: #belu.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesASpeedCardOnHimselfAndItIncrementsInOneTheResultOfThrowingTheDices [
	| aBoardGame aGroupOfPlayers overloadCard pauPosition beluPosition speedCard aSequenceOfDiceResults cards anotherOverloadCard repetitionCard |	
	overloadCard := Overload new.
	speedCard:= Speed new.
	anotherOverloadCard := Overload new.
	anotherSpeedCard := Speed new.
	repetitionCard:= Repetition new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { overloadCard . speedCard  . anotherOverloadCard . anotherSpeedCard . repetitionCard }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.
	pauPosition := Tracker of: #pau standingOn: 19 after: 1.
	beluPosition := Tracker of: #belu standingOn: 11 after: 1.
	
	aBoardGame affect: #pau using: speedCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnAccelerationCardAndIncrementsInOneTheResultOfAllCurrentPlayers [
	| aBoardGame aGroupOfPlayers pauPosition beluPosition speedCard accelerationCard aSequenceOfDiceResults cards anotherAaccelerationCard aThirdSpeedCard |
	speedCard:= Speed new.
	accelerationCard:= Acceleration new.
	anotherSpeedCard:= Speed new.
	anotherAaccelerationCard:= Acceleration new.
	aThirdSpeedCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { speedCard . accelerationCard . anotherSpeedCard . anotherAaccelerationCard . aThirdSpeedCard  }.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 19 after: 1.
	beluPosition := Tracker of: #belu standingOn: 12 after: 1.
	
	aBoardGame affect: #pau using: accelerationCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnOverloadCardOnAnotherPlayerAndItReducesInTwoTheResultOfThrowingADice [
	| aBoardGame aGroupOfPlayers overloadCard pauPosition beluPosition aSequenceOfDiceResults cards speedCard doOverCard acceleratioCard repetitionCard |
	overloadCard := Overload new.
	speedCard := Speed new.
	doOverCard := DoOver new.
	acceleratioCard := Acceleration new.
	repetitionCard := Repetition new.
	aGroupOfPlayers := {#pau . #belu}.
	aSequenceOfDiceResults := #(9 10 7 3).
	cards := { overloadCard . speedCard . doOverCard . acceleratioCard . repetitionCard}.
	aBoardGame := self generateABoardGamePlayedBy: aGroupOfPlayers  using: cards andBasedOn: aSequenceOfDiceResults.

	pauPosition := Tracker of: #pau standingOn: 29 after: 1.
	beluPosition := Tracker of: #belu standingOn: 25 after: 1.
		
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	aBoardGame affect: #belu using: overloadCard by: #pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testEffectsDistribution [
	|atomicBombEffect speedUpEffect wormHoleEffect moonWalkEffect nullEffect effectsDistribution effectManagerDistribution fields anotherMoonWalkEffect |
	atomicBombEffect:= ProbabilityEvent with: 0.02 of: (AtomicBomb new). 
	speedUpEffect:= ProbabilityEvent with: 0.2 of: (SpeedUp new). 
	wormHoleEffect:= ProbabilityEvent with: 0.2 of: (WormHole new). 
	moonWalkEffect:=ProbabilityEvent with: 0.05 of: (MoonWalk with:3).
	anotherMoonWalkEffect:=ProbabilityEvent with: 0.05 of: (MoonWalk with:4).
	nullEffect:= ProbabilityEvent with: 0.48 of: (NoEffect new).
	effectsDistribution:=OrderedCollection newFrom: {atomicBombEffect . speedUpEffect . wormHoleEffect . moonWalkEffect .anotherMoonWalkEffect.nullEffect  }.
	effectManagerDistribution:= RandomProbabilityEventManager basedOn: effectsDistribution.
	fields:= effectManagerDistribution generate: 1100.
	self assert: fields areDistributedBasedOn: effectsDistribution  withTolerance: 5.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testEffectsDistributionWithCardDealerEffect [
	| atomicBombEffect speedUpEffect wormHoleEffect moonWalkEffect nullEffect effectsDistribution effectManagerDistribution fields cardDealerEffect |
	atomicBombEffect:= ProbabilityEvent with: 0.02 of: (AtomicBomb new). 
	speedUpEffect:= ProbabilityEvent with: 0.2 of: (SpeedUp new). 
	cardDealerEffect:= ProbabilityEvent with: 0.1 of: (CardDealer new). 
	wormHoleEffect:= ProbabilityEvent with: 0.2 of: (WormHole new). 
	moonWalkEffect:=ProbabilityEvent with: 0.1 of: (MoonWalk new).
	nullEffect:= ProbabilityEvent with: 0.38 of: (NoEffect new).
	effectsDistribution:=OrderedCollection newFrom: {atomicBombEffect . speedUpEffect . wormHoleEffect . moonWalkEffect . nullEffect . cardDealerEffect }.
	effectManagerDistribution:= RandomProbabilityEventManager basedOn: effectsDistribution.
	fields:= effectManagerDistribution generate: 1100.
	
	self assert: fields areDistributedBasedOn: effectsDistribution  withTolerance: 5.
]

{ #category : #circularBoardTests }
BoardGameTest >> testTheBoardIsCircular [
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.

	pauPosition := Tracker of: #pau standingOn: 7 after: 2.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAMoonWalkFieldTheRestOfThePlayersMustGoBackwardsNFields [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.

	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 32 after: 1.
	malePosition := Tracker of: #male standingOn: 30 after: 1.
	1 to: 15 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{beluPosition . malePosition . pauPosition })
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAMoonWalkFieldTheRestOfThePlayersMustGoBackwardsNFieldsAndTheRoundChangesWhenMoveingBackwards [
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition |
	firstDice := DeterministicDice with: #(10 14 13 1).
	secondDice := DeterministicDice with: #(14 8 6 2 1).
	thirdDice := DeterministicDice with: #(9 8 2 6 3 4).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.

	pauPosition := Tracker of: #pau standingOn: 23 after: 2.
	beluPosition := Tracker of: #belu standingOn: 43 after: 1.
	malePosition := Tracker of: #male standingOn: 34 after: 1.
		
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{ pauPosition . beluPosition . malePosition }).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnASpeedUpFieldHeAdvancesFourMoreFields [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.

	pauPosition := Tracker of: #pau standingOn: 31 after: 1.
	beluPosition := Tracker of: #belu standingOn: 34 after: 1.
	malePosition := Tracker of: #male standingOn: 13 after: 1.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{beluPosition . pauPosition . malePosition })
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnASpeedUpFieldHeAdvancesFourMoreFieldsAndTheRoundChangesWhenMoveingForward [
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.

	pauPosition := Tracker of: #pau standingOn: 2 after: 3.
	beluPosition := Tracker of: #belu standingOn: 37 after: 2.
	malePosition := Tracker of: #male standingOn: 14 after: 2.
	1 to: 13 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . beluPosition . malePosition })
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAWormHoleFieldHeMovesBackwardsFourFields [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Tracker of: #pau standingOn: 31 after: 1.
	beluPosition := Tracker of: #belu standingOn: 14 after: 1.
	malePosition := Tracker of: #male standingOn: 13 after: 1.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . beluPosition . malePosition})
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAWormHoleFieldHeMovesBackwardsFourFieldsAndTheRoundChangesWhenMoveingBackwards [
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	
	pauPosition := Tracker of: #pau standingOn: 43 after: 1.
	beluPosition := Tracker of: #belu standingOn: 15 after: 1.
	malePosition := Tracker of: #male standingOn: 49 after: 1.
		
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{malePosition . pauPosition . beluPosition }).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAnAtomicBombAllPlayersMoveToFieldOne [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.

	pauPosition := Tracker of: #pau standingOn: 1 after: 1.
	beluPosition := Tracker of: #belu standingOn: 1 after: 1.
	malePosition := Tracker of: #male standingOn: 1 after: 1.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{malePosition . beluPosition . pauPosition })
]
