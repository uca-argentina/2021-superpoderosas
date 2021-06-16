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
	| aGroupOfDices aDiceCup aSpinNumber aNumberOfFields aBoard aBoardGame aGroupOfPlayers fields aDeck |
	aGroupOfPlayers := {#pau . #male . #belu}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	fields:= self generateManually: aNumberOfFields.
	aBoard := Board has:fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
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
BoardGameTest >> generateDeck [
	| cards aDeck |
	cards := OrderedCollection newFrom: { Cancellation new . Acceleration new . Speed new . DoOver new . Repetition new . Overload new}.
	aDeck := RandomDeck containing: cards.
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
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields anOverloadCard aDeck |
	anOverloadCard := Overload new.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {#pau}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber aBoard fields aDeck |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {#pau . #male . #belu . #juli}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
		
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
 		
	| aBoardGame pauPosition beluPosition juliPosition malePosition pau belu male juli |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
	juli:= aBoardGame findPlayerNamed: #juli.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	pauPosition := Position of: pau standingOn: 61 after: 1.
	1 to: 18 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAWinner [
	| aBoardGame pau |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
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
	| aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber aBoard fields aDeck pau jorge |
	aDice := DeterministicDice with: #(20 15 26 37).
	aGroupOfPlayers := {#pau. #jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 54.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=3.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	jorge:= aBoardGame findPlayerNamed: #jorge.
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
	self assert: ((aBoardGame detectPositionOf: jorge)field) equals: 14.
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
	self assert: ((aBoardGame detectPositionOf: jorge)field) equals: 49.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 51.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 49.
	self assert: ((aBoardGame detectPositionOf: pau) round) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) round) equals: 3.
	aBoardGame nextTurn.
	self assert: aBoardGame winner equals: jorge.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
 		
	| aBoardGame pauPosition pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	
	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame pauPosition pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	pauPosition := Position of: pau standingOn: 5 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	|  aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber aBoard pauPosition fields aDeck pau |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {#pau}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManually: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	pauPosition := Position of: pau standingOn: 25 after: 1.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).

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
	aBoard:= Board has: fields.
	aDeck := self generateDeck.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste ONE player'].
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testACancellationCardCanAlsoBeUsedByAPlayerIfItIsNotHisTurn [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields speedCard cancellationCard aDeck pau belu |
	speedCard:= Speed new.
	cancellationCard := Cancellation new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . cancellationCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	aBoardGame a: speedCard wantsToBeThrownTo: belu by: pau.
	aBoardGame nextTurn.
	cancellationCard of: speedCard wantsToBeThrownTo: belu by: pau at: aBoardGame.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame influentialCardsOf: belu) equals: (OrderedCollection new).
	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasNoEffect [
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields overloadCard aDeck pau |
	overloadCard := Overload new.
	aDice := DeterministicDice with: #(10 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { Acceleration new . Cancellation  new . DoOver new . Speed new . Repetition new }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.	
	pau:= aBoardGame findPlayerNamed: #pau.
	self 
		should:[aBoardGame a: overloadCard wantsToBeThrownTo: pau by: pau.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A player must have a card in hand in order to use it' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseADoOverCardWhenTheLastCardPlayedHadASpeedEffectOutsideHisTurn [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields aDeck speedCard doOverCard pau belu |
	aDice := DeterministicDice with: #(9 10 7 3).
	speedCard := Speed new.
	doOverCard := DoOver new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . doOverCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.

	aBoardGame nextTurn.
	speedCard wantsToBeThrownTo: pau by: belu at: aBoardGame.
	aBoardGame nextTurn.
	
	"fijarnos que la do over usa cosas que ya no se usan"
	
	self 
		should:[doOverCard wantsToBeThrownTo: pau by: pau at: aBoardGame] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerCanNotUseASpeedUpCardIfItIsNotHisTurn [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields aDeck speedCard pau |
	aDice := DeterministicDice with: #(9 10 7 3).
	speedCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	aBoardGame nextTurn.
	
	self 
		should:[speedCard wantsToBeThrownTo: pau by: pau at: aBoardGame.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'All permanent cards can only be played when it is the turn of the player' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHas2CardsAtTheBegginingOfTheGame [
	| aBoardGame pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	self assert: (aBoardGame cardsInHandOf: pau) size equals: 2.
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerHasThreeCardsAfterLandingOnAFieldWithACardDealerEffect [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields aDeck pau |
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := self generateDeck.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	aBoardGame nextTurn.
	self assert: (aBoardGame cardsInHandOf: pau) size equals: 3.
]

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: pau.	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerMustHaveASpeedCardInOrderToBeCancelled [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame  aSpinNumber aBoard fields  speedCard cancellationCard aDeck aGroupOfPlayers pau belu |
	speedCard := Speed new.
	cancellationCard := Cancellation new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . cancellationCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.

	self 
		should:[cancellationCard of: speedCard wantsToBeThrownTo: belu by: pau at: aBoardGame] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The player must have the influential card needed to be cancelled' ].
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesASpeedCard [
	| aGroupOfDices  aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields  speedCard cancellationCard aDeck pau belu |
	speedCard := Speed new.
	cancellationCard := Cancellation new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . cancellationCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	speedCard wantsToBeThrownTo: pau by: pau at: aBoardGame.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	cancellationCard of: speedCard wantsToBeThrownTo: pau by: belu at: aBoardGame.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame influentialCardsOf: belu)  equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesACancellationCardAndRemovesAnAccelerationCard [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields cancellationCard accelerationCard aDeck pau belu |
	cancellationCard := Cancellation new.
	accelerationCard := Acceleration new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { cancellationCard . accelerationCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	aBoardGame a: accelerationCard wantsToBeThrownBy: pau.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	cancellationCard of: accelerationCard wantsToBeThrownBy: pau at: aBoardGame.
	aBoardGame nextTurn.
	self assert: (aBoardGame influentialCardsOf: belu) equals: (OrderedCollection new).
	self assert: (aBoardGame influentialCardsOf: pau) equals: (OrderedCollection new).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aGroupOfDices  aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields doOverCard  pauPosition beluPosition speedCard aDeck pau belu |
	aDice := DeterministicDice with: #(9 10 7 3).
	speedCard:= Speed new.
	doOverCard := DoOver new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . doOverCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau  standingOn: 1 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	
	doOverCard wantsToBeThrownTo: pau by: pau at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadASpeedEffect [
	| aGroupOfDices  aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields  doOverCard  pauPosition beluPosition speedCard aDeck pau belu |
	aDice := DeterministicDice with: #(9 10 7 3).
	speedCard:= Speed new.
	doOverCard := DoOver new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . doOverCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 20 after: 1.
	beluPosition := Position of: belu standingOn: 11 after: 1.
		
	speedCard wantsToBeThrownTo: pau by: pau at: aBoardGame.
	aBoardGame nextTurn.
	doOverCard wantsToBeThrownTo: pau by: belu at: aBoardGame.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedHadAnAccelerationEffect [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields  doOverCard  pauPosition beluPosition accelerationCard aDeck pau belu |
	aDice := DeterministicDice with: #(9 10 7 3).
	accelerationCard := Acceleration new.
	doOverCard := DoOver new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { accelerationCard . doOverCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 20 after: 1.
	beluPosition := Position of: belu standingOn: 13 after: 1.
		
	accelerationCard wantsToBeThrownBy: pau at: aBoardGame.
	aBoardGame nextTurn.
	doOverCard wantsToBeThrownBy: belu at: aBoardGame.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasACancellationCard [
	| aGroupOfDices  aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields  doOverCard cancellationCard aDeck speedUpCard pau belu |
	aDice := DeterministicDice with: #(9 10 7 3).
	doOverCard := DoOver new.
	cancellationCard := Cancellation new.
	speedUpCard:= Speed new.
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: {cancellationCard . doOverCard . speedUpCard}.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	aBoardGame nextTurn.
	speedUpCard wantsToBeThrownTo: belu by: belu at: aBoardGame.
	cancellationCard of: speedUpCard wantsToBeThrownTo: belu by: pau at: aBoardGame.
	aBoardGame nextTurn.
	doOverCard wantsToBeThrownTo: belu by: pau at: aBoardGame.
	self assert:  (aBoardGame influentialCardsOf: pau)  equals: (OrderedCollection new).
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasARepeatCard [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields doOverCard pauPosition beluPosition repeatCard aDeck pau belu |
	doOverCard:= DoOver new.
	repeatCard := Repetition new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { doOverCard . repeatCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 13 after: 1.
	beluPosition := Position of: belu standingOn: 6 after: 1.
		
	aBoardGame nextTurn.
	repeatCard wantsToBeThrownTo: pau by:belu at: aBoardGame.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	doOverCard wantsToBeThrownTo: belu by: pau at: aBoardGame.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenAtomicBombEffecttHasBeenAppliedLast [
	| aGroupOfDices  aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields  repeatCard  pauPosition beluPosition speedCard malePosition aDeck pau belu male |
	aDice := DeterministicDice with: #(60 10 1 44).
	repeatCard := Repetition new.
	speedCard := Speed new.
	aGroupOfPlayers := {#pau . #belu . #male}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { repeatCard . speedCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
	pauPosition := Position of: pau standingOn: 1 after: 2.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 1 after: 1.
			
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	repeatCard wantsToBeThrownBy: pau at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition . malePosition  }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenMoonWalkEffecttHasBeenAppliedLast [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields repeatCard pauPosition beluPosition speedCard malePosition aDeck pau belu male |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	aDice := DeterministicDice with: #(13 4  22).
	aGroupOfPlayers := {#pau . #belu . #male}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { repeatCard . speedCard}.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
	pauPosition := Position of: pau standingOn: 3 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	malePosition := Position of: male standingOn: 12 after: 1.
		
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	repeatCard wantsToBeThrownTo: pau by: belu at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: { malePosition . pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoDiceHasBeenThrowsThusItHasNoEffect [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields repeatCard pauPosition beluPosition speedCard aDeck pau belu |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { repeatCard . speedCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 1 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
	
	repeatCard wantsToBeThrownTo: belu by: belu at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenNoEffectHasBeenAppliedLast [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields repeatCard pauPosition beluPosition speedCard aDeck pau belu |
	repeatCard := Repetition new.
	speedCard:= Speed new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { repeatCard . speedCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 10 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
		
	aBoardGame nextTurn.
	repeatCard wantsToBeThrownTo: belu by: belu at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesARepeatWhenSpeedEffecttHasBeenAppliedLast [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields repeatCard pauPosition beluPosition speedCard aDeck pau belu|
	repeatCard := Repetition new.
	speedCard:= Speed new.
	aDice := DeterministicDice with: #(29 10 1 10).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { repeatCard . speedCard  }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 38 after: 1.
	beluPosition := Position of: belu standingOn: 1 after: 1.
		
	aBoardGame nextTurn.
	repeatCard wantsToBeThrownTo: pau by: belu at: aBoardGame.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesASpeedCardOnHimselfAndItIncrementsInOneTheResultOfThrowingTheDices [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields overloadCard pauPosition beluPosition speedCard aDeck pau belu |
	overloadCard := Overload new.
	speedCard:= Speed new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { overloadCard . speedCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 19 after: 1.
	beluPosition := Position of: belu standingOn: 11 after: 1.
	
	speedCard wantsToBeThrownTo: pau by: pau at: aBoardGame.	
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnAccelerationCardAndIncrementsInOneTheResultOfAllCurrentPlayers [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields pauPosition beluPosition speedCard accelerationCard aDeck pau belu |
	speedCard:= Speed new.
	accelerationCard:= Acceleration new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { speedCard . accelerationCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 19 after: 1.
	beluPosition := Position of: belu standingOn: 12 after: 1.
	
	accelerationCard wantsToBeThrownBy: pau at: aBoardGame.	
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition . beluPosition }).
	
]

{ #category : #playingWithCardsTests }
BoardGameTest >> testAPlayerUsesAnOverloadCardOnAnotherPlayerAndItReducesInTwoTheResultOfThrowingADice [
	| aGroupOfDices aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard fields overloadCard pauPosition beluPosition aDeck pau belu |
	overloadCard := Overload new.
	aDice := DeterministicDice with: #(9 10 7 3).
	aGroupOfPlayers := {#pau . #belu}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=5.
	fields:= self generateManuallyIncludingCardDealer: aNumberOfFields.
	aBoard:= Board has: fields.
	aDeck := DeterministicDeck containing: { overloadCard }.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	pauPosition := Position of: pau standingOn: 29 after: 1.
	beluPosition := Position of: belu standingOn: 25 after: 1.
		
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	overloadCard wantsToBeThrownTo: belu by: pau at: aBoardGame.
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
	| aBoardGame pauPosition pau |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	pau:= aBoardGame findPlayerNamed: #pau.
	pauPosition := Position of: pau standingOn: 7 after: 2.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testWhenAPlayerFellsOnAMoonWalkFieldTheRestOfThePlayersMustGoBackwardsNFields [
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition pau belu male |
	firstDice := DeterministicDice with: #(10 14 13 1).
	secondDice := DeterministicDice with: #(14 8 6 2 1).
	thirdDice := DeterministicDice with: #(9 8 2 6 3 4).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition pau belu male |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
		| firstDice secondDice thirdDice aBoardGame pauPosition beluPosition malePosition pau belu male |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
	| aBoardGame pauPosition beluPosition malePosition pau belu male |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	pau:= aBoardGame findPlayerNamed: #pau.
	belu:= aBoardGame findPlayerNamed: #belu.
	male:= aBoardGame findPlayerNamed: #male.
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
