Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	| aGroupOfDices aDiceCup aSpinNumber aNumberOfFields aBoard aBoardGame aGroupOfPlayers |
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu'}.
	aGroupOfDices := {firstDice.
	secondDice.
	thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	aBoard := DeterministicBoard of: aNumberOfFields.
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

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithASinglePlayerAndASingleRound [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard |
	aPlayer := 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoard:= DeterministicBoard of: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber aBoard |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu' . 'Juli'}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber:=1.
	aBoard:= DeterministicBoard of: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
		
	^ aBoardGame
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
	| pau aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge aSpinNumber aBoard |
	pau := 'Pau'.
	jorge := 'Jorge'.
	aDice := DeterministicDice with: #(20 15 26 37).
	aGroupOfPlayers := {pau. jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 54.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=3.
	aBoard:= DeterministicBoard of: aNumberOfFields.
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
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber aBoard pauPosition |
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
	aBoard:= DeterministicBoard of: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {pauPosition}).

]

{ #category : #validationTests }
BoardGameTest >> testABoardGameNeedsAtLeastOnePlayer [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber aBoard |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 49.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoard:= DeterministicBoard of: aNumberOfFields.

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

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayerAndASingleRound.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: 'Pau'.	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testEffectsDistribution [
		| firstDice secondDice thirdDice aGroupOfPlayers aGroupOfDices aDiceCup aNumberOfFields aSpinNumber aBoardGame aBoard |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu'}.
	aGroupOfDices := {firstDice.
	secondDice.
	thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	aBoard:= RandomBoard of: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: ((aBoard) amountOfFieldsWith: AtomicBomb)
		equals: ((aNumberOfFields *0.02) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: WormHole )
		equals: ((aNumberOfFields *0.2) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: SpeedUp)
		equals: ((aNumberOfFields *0.2) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: MoonWalk)
		equals: ((aNumberOfFields *0.1) asInteger ).
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
