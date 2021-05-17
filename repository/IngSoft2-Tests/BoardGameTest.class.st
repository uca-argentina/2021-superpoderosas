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
	aBoard := DeterministicBoard size: aNumberOfFields.
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
BoardGameTest >> newBoardGameWithASinglePlayer [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber aBoard |
	aPlayer := 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 61.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoard:= DeterministicBoard size: aNumberOfFields.
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
	aBoard:= DeterministicBoard size: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
		
	^ aBoardGame
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 21'  '2) Belu, round: 1 field: 14'  '3) Juli, round: 1 field: 13'  '4) Male, round: 1 field: 11')).
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has not finished yet, so it does not have a winner.' ].
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAFinalRanking [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 1 field: 46' . '2) Male, round: 1 field: 21' . '3) Belu, round: 1 field: 13'})
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasARanking [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 18 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {'1) Pau, round: 1 field: 61'}).
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
	aBoardGame := self newBoardGameWithASinglePlayer.
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
	aBoard:= DeterministicBoard size: aNumberOfFields.
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
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has already finished, contestants can not play anymore.' ].
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersThatChangePositionOvertime [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					({'1) Pau, round: 1 field: 31' . '2) Belu, round: 1 field: 14'. '3) Male, round: 1 field: 13'})).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersThatChangeRoundNumberOvertime [
	| aBoardGame |
	aBoardGame := self creationOfAnotherBoardGameWithThreePlayers.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 2 field: 33' . '2) Belu, round: 2 field: 10' . '3) Male, round: 1 field: 43'})
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersWithAnInitialPosition [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.

	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: { '1) Pau, round: 1 field: 1'. '2) Male, round: 1 field: 1'. '3) Belu, round: 1 field: 1'}).

	
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameIsInProcess [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self deny: (aBoardGame isFinished).
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameKnowsThePlayersInitialPosition [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame ranking) equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 1')).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
		
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 5')).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber aBoard |
	aPlayer:= 'Pau'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoard:= DeterministicBoard size: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 25')).

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
	aBoard:= DeterministicBoard size: aNumberOfFields.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste ONE player'].
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasASpeedUpEffect [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Belu, round: 1 field: 34'.'2) Pau, round: 1 field: 31' . '3) Male, round: 1 field: 13'})
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasAtomicBombEffect [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 1 field: 1'.'2) Male, round: 1 field: 1' . '3) Belu, round: 1 field: 1'})
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasMoonWalkEffect [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 15 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{ '1) Belu, round: 1 field: 32' .'2) Male, round: 1 field: 30' . '3) Pau, round: 1 field: 1'})
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasNoEffect [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 4 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 1 field: 31' .'2) Belu, round: 1 field: 14'. '3) Male, round: 1 field: 11'}).

]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAFieldHasWormHoleEffect [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 1 field: 31' . '2) Belu, round: 1 field: 14'. '3) Male, round: 1 field: 13'})
]

{ #category : #circularBoardTests }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: 'Pau'.	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAnotherFieldHasMoonWalkEffect [
		| firstDice secondDice thirdDice aBoardGame |
	firstDice := DeterministicDice with: #(10 14 13 1).
	secondDice := DeterministicDice with: #(14 8 6 2 1).
	thirdDice := DeterministicDice with: #(9 8 2 6 3 4).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
		
	1 to: 7 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 2 field: 23' . '2) Belu, round: 1 field: 43' . '3) Male, round: 1 field: 34'}).
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAnotherFieldHasSpeedUpEffect [
		| firstDice secondDice thirdDice aBoardGame |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
	1 to: 13 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 3 field: 2' . '2) Belu, round: 2 field: 37' . '3) Male, round: 2 field: 14'})
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAnotherFieldHasWormHoleEffect [
		| firstDice secondDice thirdDice aBoardGame |
	firstDice := DeterministicDice with: #(6 14 7 2).
	secondDice := DeterministicDice with: #(1 8 5 11 8).
	thirdDice := DeterministicDice with: #(9 4 2 17 12).
	aBoardGame := self creationOfBoardGameWithThatUsesA: firstDice a: secondDice andA: thirdDice.
		
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Male, round: 1 field: 49' . '2) Pau, round: 1 field: 43' .'3) Belu, round: 1 field: 15'}).
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
	aBoard:= RandomBoard size: aNumberOfFields.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		on: aBoard
		winnedWhenReach: aSpinNumber.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: ((aBoard) amountOfFieldsWith: AtomicBombEffect)
		equals: ((aNumberOfFields *0.02) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: WormHoleEffect )
		equals: ((aNumberOfFields *0.2) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: SpeedUpEffect)
		equals: ((aNumberOfFields *0.2) asInteger ).
	self
		assert: ((aBoard) amountOfFieldsWith: MoonWalkEffect)
		equals: ((aNumberOfFields *0.1) asInteger ).
]

{ #category : #circularBoardTests }
BoardGameTest >> testTheBoardIsCircular [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 19 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {'1) Pau, round: 2 field: 7'}).
]
