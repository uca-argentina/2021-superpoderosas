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
	| aGroupOfDices aDiceCup aSpinNumber aNumberOfFields aBoard aBoardGame aGroupOfPlayers fields cards pau belu male anOverloadCard |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	aGroupOfPlayers := {pau . male . belu}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	fields:= self generateManually: aNumberOfFields.
	aBoard := Board has:fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
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
BoardGameTest >> generateManuallyIncludingCards: aNumberOfFields [ 
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
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields anOverloadCard cards |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	aPlayer := Player named: 'Pau' with: cards.
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
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber aBoard fields anOverloadCard cards pau belu male juli |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	juli:= Player named: 'Juli' with: cards.
	aGroupOfPlayers := {pau . male . belu . juli}.
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
 		
	| aBoardGame pauPosition beluPosition juliPosition malePosition cards pau belu male juli anOverloadCard |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	juli:= Player named: 'Juli' with: cards.
	pauPosition := Position of: pau standingOn: 21 after: 1.
	beluPosition := Position of: belu standingOn: 14 after: 1.
	juliPosition := Position of: juli standingOn: 13 after: 1.
	malePosition := Position of: male standingOn: 11 after: 1.
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 46 after: 1.
	beluPosition := Position of: belu standingOn: 13 after: 1.
	malePosition := Position of: male standingOn: 21 after: 1.
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . malePosition . beluPosition})
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasARanking [
	| aBoardGame pauPosition anOverloadCard cards pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	pauPosition := Position of: pau standingOn: 61 after: 1.
	1 to: 18 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAWinner [
	| aBoardGame anOverloadCard cards pau |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	1 to: 16 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame winner 
		equals: pau.
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
	| pau aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge aSpinNumber aBoard fields anOverloadCard cards |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	jorge:= Player named: 'Jorge' with: cards.
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 31 after: 1.
	beluPosition := Position of: belu standingOn: 14 after: 1.
	malePosition := Position of: male standingOn: 13 after: 1.
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 33 after: 2.
	beluPosition := Position of: belu standingOn: 10 after: 2.
	malePosition := Position of: male standingOn: 43 after: 1.
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 1 after: 1.

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
 		
	| aBoardGame pauPosition anOverloadCard cards pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	
	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame pauPosition anOverloadCard cards pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	pauPosition := Position of: pau standingOn: 5 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber aBoard pauPosition fields anOverloadCard cards |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	aPlayer := Player named: 'Pau' with: cards.
	pauPosition := Position of: aPlayer standingOn: 25 after: 1.
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

{ #category : #playingWithCardsTests }
BoardGameTest >> testACancellationCardCanAlsoBeUsedByAPlayerIfItIsNotHisTurn [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anotherPlayer speedCard cancellationCard |
	speedCard:= Speed new.
	cancellationCard:= Cancellation new.
	cards:=OrderedCollection newFrom:{speedCard.cancellationCard}.
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
	aBoardGame a: speedCard wantsToBeThrownTo: anotherPlayer by: aPlayer.
	aBoardGame nextTurn.
	aBoardGame a: cancellationCard of: speedCard wantsToBeThrowTo: anotherPlayer by: aPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: anotherPlayer influentialCards equals: (OrderedCollection new).
	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasNoEffect [
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 31 after: 1.
	beluPosition := Position of: belu standingOn: 14 after: 1.
	malePosition := Position of: male standingOn: 11 after: 1.
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
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards overloadCard anotherPlayer|
	overloadCard := Overload new.
	cards:=OrderedCollection newFrom:{#card1 . #card2 }.
	aPlayer := Player named: 'Pau' with: cards.
	anotherPlayer := Player named: 'Belu' with: cards.
	aDice := DeterministicDice with: #(10 10 7 3).
	aGroupOfPlayers := {aPlayer . anotherPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.	
	self 
		should:[aBoardGame a: overloadCard wantsToBeThrownTo: anotherPlayer by: aPlayer.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A player must have a card in hand in order to use it' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseADoOverCardWhenTheLastCardPlayedHadASpeedEffectOutsideHisTurn [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer speedCard |
	doOverCard := DoOver new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{doOverCard . speedCard}.
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
	aBoardGame nextTurn.
	aBoardGame a: speedCard wantsToBeThrownTo: aPlayer by: anotherPlayer.
	aBoardGame nextTurn.
	
	
	self 
		should:[aBoardGame a: doOverCard wantsToBeThrownTo: aPlayer by: anotherPlayer] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseASpeedUpCardIfItIsNotHisTurn [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards overloadCard anotherPlayer speedCard |
	overloadCard := Overload new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{overloadCard . speedCard}.
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
		
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame a: speedCard wantsToBeThrownTo: aPlayer by: aPlayer.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
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

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHasTwoCardsAtTheBeginning [
	|cards aCancellationCard anAccelerationCard anotherSetOfCards |
	aCancellationCard:= Cancellation new.
	anAccelerationCard:= Acceleration new.
	cards:=OrderedCollection newFrom:{anAccelerationCard.aCancellationCard.anAccelerationCard}.
	anotherSetOfCards:=OrderedCollection newFrom:{anAccelerationCard}.
	self 
		should:[Player named: 'Pau' with: cards.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A player must have two cards in hand at the beginning of the game' ].
	self 
		should:[Player named: 'Belu' with: anotherSetOfCards.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A player must have two cards in hand at the beginning of the game' ].
	
	

	
	
]

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame anOverloadCard cards pau |
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: pau.	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerMustHaveASpeedCardInOrderToBeCancelled [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anotherPlayer speedCard cancellationCard |
	speedCard:= Speed new.
	cancellationCard:= Cancellation new.
	cards:=OrderedCollection newFrom:{speedCard.cancellationCard}.
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
	self 
		should:[aBoardGame a: cancellationCard of: speedCard wantsToBeThrowTo: anotherPlayer by: aPlayer] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The player must have the influential card needed to be cancelled' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesASpeedCard [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anotherPlayer speedCard cancellationCard |
	speedCard:= Speed new.
	cancellationCard:= Cancellation new.
	cards:=OrderedCollection newFrom:{speedCard.cancellationCard}.
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
	aBoardGame a: speedCard wantsToBeThrownTo: anotherPlayer by: aPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame a: cancellationCard of: speedCard wantsToBeThrowTo: anotherPlayer by: aPlayer.
	aBoardGame nextTurn.
	
	self assert: anotherPlayer influentialCards equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesAnAccelerationCard [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anotherPlayer cancellationCard accelerationCard |
	cancellationCard:= Cancellation new.
	accelerationCard:= Acceleration new.
	cards:=OrderedCollection newFrom:{accelerationCard.cancellationCard}.
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
	aBoardGame a: accelerationCard wantsToBeThrownBy: aPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame a: cancellationCard of: accelerationCard wantsToBeThrownBy: aPlayer.
	aBoardGame nextTurn.
	self assert: anotherPlayer influentialCards equals: (OrderedCollection new).
	self assert: aPlayer influentialCards equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer pauPosition beluPosition speedCard |
	doOverCard := DoOver new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{doOverCard . speedCard}.
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
	pauPosition := Position of: aPlayer standingOn: 1 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 1 after: 1.
		
	aBoardGame a: doOverCard wantsToBeThrownTo: aPlayer by: aPlayer.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadASpeedEffect [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer pauPosition beluPosition speedCard |
	doOverCard := DoOver new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{doOverCard . speedCard}.
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
	pauPosition := Position of: aPlayer standingOn: 20 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 11 after: 1.
		
	aBoardGame a: speedCard wantsToBeThrownTo: aPlayer by: aPlayer.
	aBoardGame nextTurn.
	aBoardGame a: doOverCard wantsToBeThrownTo: aPlayer by: anotherPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadAnAccelerationEffect [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer pauPosition beluPosition accelerationCard |
	doOverCard := DoOver new.
	accelerationCard:= Acceleration new.
	cards:=OrderedCollection newFrom:{doOverCard . accelerationCard}.
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
	pauPosition := Position of: aPlayer standingOn: 20 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 13 after: 1.
		
	aBoardGame a: accelerationCard wantsToBeThrownBy: aPlayer.
	aBoardGame nextTurn.
	aBoardGame a: doOverCard wantsToBeThrownBy: anotherPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasACancellationCard [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer cancellationCard|
	doOverCard := DoOver new.
	cancellationCard:= Cancellation  new.
	cards:=OrderedCollection newFrom:{doOverCard . cancellationCard}.
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
	aBoardGame nextTurn.
	"agregar mas cartas"
	aBoardGame a: cancellationCard of: doOverCard wantsToBeThrowTo: aPlayer by: anotherPlayer.
	aBoardGame nextTurn.
	aBoardGame a: doOverCard of: cancellationCard wantsToBeThrowTo: aPlayer by: anotherPlayer.
	self assert: aPlayer influentialCards equals: (OrderedCollection new).
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasARepeatCard [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards doOverCard anotherPlayer pauPosition beluPosition repeatCard |
	doOverCard := DoOver new.
	repeatCard := Repetition new.
	cards:=OrderedCollection newFrom:{doOverCard . repeatCard}.
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
	pauPosition := Position of: aPlayer standingOn: 13 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 10 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame a: repeatCard wantsToBeThrownTo: aPlayer by:anotherPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame a: doOverCard wantsToBeThrownTo: anotherPlayer by: aPlayer.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenAtomicBombEffecttHasBeenAppliedLast [
	| aGroupOfDices pau aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards repeatCard belu male pauPosition beluPosition speedCard malePosition|
	repeatCard := Repetition new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{repeatCard . speedCard}.
	pau := Player named: 'Pau' with: cards.
	belu := Player named: 'Belu' with: cards.
	male := Player named: 'Male' with: cards.
	aDice := DeterministicDice with: #(60 10 1 44).
	aGroupOfPlayers := {pau . belu . male}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
	pauPosition := Position of: pau standingOn: 1 after: 2.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 1 after: 1.
			
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame a: repeatCard wantsToBeThrownBy: pau.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition . malePosition  }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenMoonWalkEffecttHasBeenAppliedLast [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards repeatCard belu male pau pauPosition beluPosition speedCard malePosition |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{repeatCard . speedCard}.
	pau := Player named: 'Pau' with: cards.
	belu := Player named: 'Belu' with: cards.
	male := Player named: 'Male' with: cards.
	aDice := DeterministicDice with: #(13 4  22).
	aGroupOfPlayers := {pau . belu . male}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
	pauPosition := Position of: pau standingOn: 3 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 12 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame a: repeatCard wantsToBeThrownTo:  pau by: belu.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: { malePosition . pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards repeatCard anotherPlayer pauPosition beluPosition speedCard |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{repeatCard . speedCard}.
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
	pauPosition := Position of: aPlayer standingOn: 1 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 1 after: 1.
		
	aBoardGame a: repeatCard wantsToBeThrownTo: anotherPlayer by: anotherPlayer.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoEffectHasBeenAppliedLast [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards repeatCard anotherPlayer pauPosition beluPosition speedCard |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{repeatCard . speedCard}.
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
	pauPosition := Position of: aPlayer standingOn: 10 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 1 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame a: repeatCard wantsToBeThrownTo: anotherPlayer by: anotherPlayer.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenSpeedEffecttHasBeenAppliedLast [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards repeatCard anotherPlayer pauPosition beluPosition speedCard |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{repeatCard . speedCard}.
	aPlayer := Player named: 'Pau' with: cards.
	anotherPlayer := Player named: 'Belu' with: cards.
	aDice := DeterministicDice with: #(29 10 1 10).
	aGroupOfPlayers := {aPlayer . anotherPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCards: aNumberOfFields.
	aBoard:= Board has: fields.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
	pauPosition := Position of: aPlayer standingOn: 38 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 1 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame a: repeatCard wantsToBeThrownTo: aPlayer by: anotherPlayer.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesASpeedCardOnHimselfAndItIncrementsInOneTheResultOfThrowingTheDices [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards overloadCard anotherPlayer pauPosition beluPosition speedCard |
	overloadCard := Overload new.
	speedCard:= Speed new.
	cards:=OrderedCollection newFrom:{overloadCard . speedCard}.
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
	pauPosition := Position of: aPlayer standingOn: 19 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 11 after: 1.
		
	aBoardGame a: speedCard wantsToBeThrownTo: aPlayer by: aPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnAccelerationCardAndIncrementsInOneTheResultOfAllCurrentPlayers [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards anotherPlayer pauPosition beluPosition speedCard accelerationCard |
	speedCard:= Speed new.
	accelerationCard:= Acceleration new.
	cards:=OrderedCollection newFrom:{speedCard.accelerationCard}.
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
	pauPosition := Position of: aPlayer standingOn: 19 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 12 after: 1.
		
	aBoardGame a: accelerationCard wantsToBeThrownBy: aPlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnOverloadCardOnAnotherPlayerAndItReducesInTwoTheResultOfThrowingADice [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cards overloadCard anotherPlayer pauPosition beluPosition |
	overloadCard := Overload new.
	cards:=OrderedCollection newFrom:{overloadCard . overloadCard }.
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
	pauPosition := Position of: aPlayer standingOn: 29 after: 1.
	beluPosition := Position of: anotherPlayer standingOn: 25 after: 1.
		
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	aBoardGame a: overloadCard wantsToBeThrownTo: anotherPlayer by: aPlayer.
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
	| aBoardGame pauPosition anOverloadCard cards pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	pauPosition := Position of: pau standingOn: 7 after: 2.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAMoonWalkFieldTheRestOfThePlayersMustGoBackwardsNFields [
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	beluPosition := Position of: belu standingOn: 32 after: 1.
	malePosition := Position of: male standingOn: 30 after: 1.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	firstDice := DeterministicDice with: #(10 14 13 1).
	secondDice := DeterministicDice with: #(14 8 6 2 1).
	thirdDice := DeterministicDice with: #(9 8 2 6 3 4).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 23 after: 2.
	beluPosition := Position of: belu standingOn: 43 after: 1.
	malePosition := Position of: male standingOn: 34 after: 1.
		
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 31 after: 1.
	beluPosition := Position of: belu standingOn: 34 after: 1.
	malePosition := Position of: male standingOn: 13 after: 1.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 2 after: 3.
	beluPosition := Position of: belu standingOn: 37 after: 2.
	malePosition := Position of: male standingOn: 14 after: 2.
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 31 after: 1.
	beluPosition := Position of: belu standingOn: 14 after: 1.
	malePosition := Position of: male standingOn: 13 after: 1.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 43 after: 1.
	beluPosition := Position of: belu standingOn: 15 after: 1.
	malePosition := Position of: male standingOn: 49 after: 1.
		
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
	| aBoardGame pauPosition beluPosition malePosition anOverloadCard cards pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	anOverloadCard := Overload new.
	cards:=OrderedCollection newFrom:{anOverloadCard . anOverloadCard }.
	pau := Player named: 'Pau' with: cards.
	belu:= Player named: 'Belu' with: cards.
	male:= Player named: 'Male' with: cards.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 1 after: 1.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{pauPosition . malePosition . beluPosition })
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testWishedMove [
"Objeto DesireMove"
"Ambas subclases van a tener a la carta que se quiere jugar. La carta cancelation va a venir ademas con el plus la carta a cancelar"
"Van a haber dos sublcases: 
1) Global -> aplica a todos los jugadores
2) Individual -> aplica a un jugador en particular"
]
