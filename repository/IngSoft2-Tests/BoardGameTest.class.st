Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#instVars : [
		'events',
		'eventsDistribution'
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
	| aGroupOfDices aDiceCup aSpinNumber aNumberOfFields aBoard aBoardGame aGroupOfPlayers fields |
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu'}.
	aGroupOfDices := {firstDice.
	secondDice.
	thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	fields:= self generateManually: aNumberOfFields.
	aBoard := Board has:fields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
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

{ #category : #fieldsEffectTests }
BoardGameTest >> generateManually: aNumberOfFields [ 
	|  fields effectToDistrubute effectDistributionFields |
	fields:= OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	effectToDistrubute := {WormHole new. SpeedUp new.AtomicBomb new.MoonWalk new}.
	effectDistributionFields := {{3 . 17}.{30 . 48}.{44}.{32 . 23}}.
	effectToDistrubute with: effectDistributionFields do:[ :effect :effectFields | 
						effectFields do: 
								[ :fieldNumber | fields at: fieldNumber put: effect ]].
	^fields.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> generateManuallyIncludingCards: aNumberOfFields [ 
	|  fields effectToDistrubute effectDistributionFields |
	fields:= OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	effectToDistrubute := {WormHole new. SpeedUp new.AtomicBomb new.MoonWalk new. CardDealer new}.
	effectDistributionFields := {{3 . 17}.{30 . 48}.{44}.{32 . 23} . {10}}.
	effectToDistrubute with: effectDistributionFields do:[ :effect :effectFields | 
						effectFields do: 
								[ :fieldNumber | fields at: fieldNumber put: effect ]].
	^fields.
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithASinglePlayerAndASingleRound [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields |
	aPlayer := 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber aBoard fields |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu' . 'Juli'}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
		
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
 		
	| aBoardGame pauPosition beluPosition juliPosition malePosition |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	pauPosition := Position of: 'Pau' standingOn: 21 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 14 after: 1.
	juliPosition := Position of: 'Juli' standingOn: 13 after: 1.
	malePosition := Position of: 'Male' standingOn: 11 after: 1.
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
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	pauPosition := Position of: 'Pau' standingOn: 46 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 13 after: 1.
	malePosition := Position of: 'Male' standingOn: 21 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 61 after: 1.
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
		equals: 'Pau'.
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
	| pau aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge aSpinNumber aBoard fields |
	pau := 'Pau'.
	jorge := 'Jorge'.
	aDice := DeterministicDice with: #(20 15 26 37).
	aGroupOfPlayers := {pau. jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 54.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=3.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 1.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self deny: aBoardGame isFinished.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 21.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 1.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 21.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 16.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 47.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 16.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 47.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 53.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 13.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 53.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 2.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 13.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 14.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 2.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 39.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 14.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 2.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 39.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 51.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 2.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 5.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 51.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 2.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 5.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 12.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 31.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 12.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 31.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 49.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 51.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 49.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: aBoardGame winner equals: jorge
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
	pauPosition := Position of: 'Pau' standingOn: 31 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 14 after: 1.
	malePosition := Position of: 'Male' standingOn: 13 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 33 after: 2.
	beluPosition := Position of: 'Belu' standingOn: 10 after: 2.
	malePosition := Position of: 'Male' standingOn: 43 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 1 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 1 after: 1.
	malePosition := Position of: 'Male' standingOn: 1 after: 1.

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
	pauPosition := Position of: 'Pau' standingOn: 1 after: 1.
	
	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pauPosition := Position of: 'Pau' standingOn: 5 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber aBoard pauPosition fields |
	aPlayer:= 'Pau'.
	pauPosition := Position of: 'Pau' standingOn: 25 after: 1.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).

]

{ #category : #validationTests }
BoardGameTest >> testABoardGameNeedsAtLeastOnePlayer [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber aBoard fields |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 49.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste ONE player'].
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasNoEffect [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Position of: 'Pau' standingOn: 31 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 14 after: 1.
	malePosition := Position of: 'Male' standingOn: 11 after: 1.
	1 to: 4 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . beluPosition . malePosition}).

]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHas2CardsAtTheBegginingOfTheGame [
	| aPlayer cards |
	cards:={'card1' . 'card2'}.
	aPlayer := Player named: 'Pau' with: cards.
		
	self assert: aPlayer cards size equals: 2.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHasThreeCardsAfterLandingOnAFieldWithACardDealerEffect [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards |
	cards:=OrderedCollection newFrom:{'card1' . 'card2'}.
	aPlayer := Player named: 'Pau' with: cards.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	self assert: aPlayer cards size equals: 3.
]

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: 'Pau'.	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAOverloadCard [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anOverloadCard anotherPlayer pauPosition beluPosition |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	aPlayer := Player named: 'Pau' with: cards.
	anotherPlayer := Player named: 'Belu' with: cards.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {aPlayer . anotherPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
	pauPosition := Position of: 'Pau' standingOn: 29 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 25 after: 1.
		
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	aBoardGame nextTurnThrowing: anOverloadCard to: anotherPlayer.
	aBoardGame nextTurn.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testEffectsDistribution [
	| aBoard atomicBombEffect speedUpEffect wormHoleEffect moonWalkEffect nullEffect effectsDistribution effectManagerDistribution fields |
	atomicBombEffect:= ProbabilityEvent with: 0.02 of: (AtomicBomb new). 
	speedUpEffect:= ProbabilityEvent with: 0.2 of: (SpeedUp new). 
	wormHoleEffect:= ProbabilityEvent with: 0.2 of: (WormHole new). 
	moonWalkEffect:=ProbabilityEvent with: 0.1 of: (MoonWalk new).
	nullEffect:= ProbabilityEvent with: 0.48 of: (NoEffect new).
	effectsDistribution:=OrderedCollection newFrom: {atomicBombEffect . speedUpEffect . wormHoleEffect . moonWalkEffect . nullEffect  }.
	effectManagerDistribution:= RandomProbabilityEventManager basedOn: effectsDistribution.
	fields:= effectManagerDistribution generate: 1100.
	
	aBoard := Board has: fields.
	self assert: fields areDistributedBasedOn: effectsDistribution  withTolerance: 5.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testEffectsDistributionWithCardDealerEffect [
	| aBoard atomicBombEffect speedUpEffect wormHoleEffect moonWalkEffect nullEffect effectsDistribution effectManagerDistribution fields cardDealerEffect |
	atomicBombEffect:= ProbabilityEvent with: 0.02 of: (AtomicBomb new). 
	speedUpEffect:= ProbabilityEvent with: 0.2 of: (SpeedUp new). 
	cardDealerEffect:= ProbabilityEvent with: 0.1 of: (CardDealer new). 
	wormHoleEffect:= ProbabilityEvent with: 0.2 of: (WormHole new). 
	moonWalkEffect:=ProbabilityEvent with: 0.1 of: (MoonWalk new).
	nullEffect:= ProbabilityEvent with: 0.38 of: (NoEffect new).
	effectsDistribution:=OrderedCollection newFrom: {atomicBombEffect . speedUpEffect . wormHoleEffect . moonWalkEffect . nullEffect . cardDealerEffect }.
	effectManagerDistribution:= RandomProbabilityEventManager basedOn: effectsDistribution.
	fields:= effectManagerDistribution generate: 1100.
	
	aBoard := Board has: fields.
	self assert: fields areDistributedBasedOn: effectsDistribution  withTolerance: 5.
]

{ #category : #circularBoardTests }
BoardGameTest >> testTheBoardIsCircular [
	| aBoardGame pauPosition |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pauPosition := Position of: 'Pau' standingOn: 7 after: 2.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAMoonWalkFieldTheRestOfThePlayersMustGoBackwardsNFields [
	| aBoardGame pauPosition beluPosition malePosition |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pauPosition := Position of: 'Pau' standingOn: 1 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 32 after: 1.
	malePosition := Position of: 'Male' standingOn: 30 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 23 after: 2.
	beluPosition := Position of: 'Belu' standingOn: 43 after: 1.
	malePosition := Position of: 'Male' standingOn: 34 after: 1.
		
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
	pauPosition := Position of: 'Pau' standingOn: 31 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 34 after: 1.
	malePosition := Position of: 'Male' standingOn: 13 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 2 after: 3.
	beluPosition := Position of: 'Belu' standingOn: 37 after: 2.
	malePosition := Position of: 'Male' standingOn: 14 after: 2.
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
	pauPosition := Position of: 'Pau' standingOn: 31 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 14 after: 1.
	malePosition := Position of: 'Male' standingOn: 13 after: 1.
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
	pauPosition := Position of: 'Pau' standingOn: 43 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 15 after: 1.
	malePosition := Position of: 'Male' standingOn: 49 after: 1.
		
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
	pauPosition := Position of: 'Pau' standingOn: 1 after: 1.
	beluPosition := Position of: 'Belu' standingOn: 1 after: 1.
	malePosition := Position of: 'Male' standingOn: 1 after: 1.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . malePosition . beluPosition })
]
