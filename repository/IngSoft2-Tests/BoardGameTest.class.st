Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #positionTests }
BoardGameTest >> creationOfBoardGameWithThreePlayers [
	| aBoardGame aGroupOfDices aDiceCup aSpinNumber aNumberOfFields secondDice firstDice aGroupOfPlayers thirdDice |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu'}.
	aGroupOfDices := {firstDice.
	secondDice.
	thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber := 3.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		onABoardOf: aNumberOfFields
		winnedWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithASinglePlayer [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers aSpinNumber |
	aPlayer := 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 20.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdDice aDiceCup aSpinNumber |
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {'Pau' . 'Male' . 'Belu' . 'Juli'}.
	aGroupOfDices := {firstDice. secondDice. thirdDice}.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aNumberOfFields := 50.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
		
	^ aBoardGame
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 21' '2) Juli, round: 1 field: 17' '3) Belu, round: 1 field: 14'  '4) Male, round: 1 field: 11')).
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameCanHaveFourPlayers [
	| aBoardGame |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	self assert: aBoardGame numberOfPlayers identicalTo: 4
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
					{'1) Pau, round: 4 field: 6' . '2) Belu, round: 3 field: 34'.
					'3) Male, round: 3 field: 29'})
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasARanking [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {'1) Pau, round: 2 field: 3'}).
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAWinner [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame winner 
		equals: 'Pau'.
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasAlreayFinishedSoNoOneCanContinuePlaying [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 34 do: [ :n | aBoardGame nextTurn ].
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has already finished, contestants can not play anymore.' ].
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameHasFinished [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame isFinished).
]

{ #category : #statusTests }
BoardGameTest >> testABoardGameHasFinishedAndHasAWinner [
	| pau aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge aSpinNumber |
	pau := 'Pau'.
	jorge := 'Jorge'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {pau. jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 20.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 1.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 1.
	aBoardGame nextTurn.
	self deny: aBoardGame isFinished.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 1.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 3.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 5.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 10.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 5.
	aBoardGame nextTurn.
	self assert: ((aBoardGame detectPositionOf: pau) field) equals: 10.
	self assert: ((aBoardGame detectPositionOf: jorge) field) equals: 8.
	aBoardGame nextTurn.
	self assert: aBoardGame winner equals: pau
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameHasFinishedAndPlayersMustBeHalted [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game has already finished, contestants can not play anymore.' ].
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasOnePlayer [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame numberOfPlayers) identicalTo: 1.
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
					{'1) Pau, round: 1 field: 31' . '2) Male, round: 1 field: 17'.
					'3) Belu, round: 1 field: 14'})
]

{ #category : #positionTests }
BoardGameTest >> testABoardGameHasThreePlayersThatChangeRoundNumberOvertime [
	| aBoardGame |
	aBoardGame := self creationOfBoardGameWithThreePlayers.
	1 to: 25 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 3 field: 11' . '2) Belu, round: 3 field: 5'.
					'3) Male, round: 2 field: 39'})
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
	
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 3')).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber |
	aPlayer:= 'Pau'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: #('1) Pau, round: 1 field: 25')).

]

{ #category : #validationTests }
BoardGameTest >> testABoardGameNeedsAtLeastOnePlayer [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup aSpinNumber |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.] 
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
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame winner equals: 'Pau'.	
]

{ #category : #fieldsEffectTests }
BoardGameTest >> testAnotherFieldHasWormHoleEffect [
		| firstDice secondDice thirdDice aGroupOfPlayers aGroupOfDices aDiceCup aNumberOfFields aSpinNumber aBoardGame |
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
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		onABoardOf: aNumberOfFields
		winnedWhenReach: aSpinNumber.
		
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	self
		assert: aBoardGame ranking
		equals:
			(OrderedCollection
				newFrom:
					{'1) Pau, round: 1 field: 31' . '2) Belu, round: 1 field: 14'. '3) Male, round: 1 field: 13'})
]

{ #category : #circularBoardTests }
BoardGameTest >> testTheBoardIsCircular [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame ranking equals: (OrderedCollection newFrom: {'1) Pau, round: 2 field: 3'}).
]
