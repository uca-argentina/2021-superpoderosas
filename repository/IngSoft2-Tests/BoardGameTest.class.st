Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #positionTest }
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
	aPlayer := Player called: 'Pau'.
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
	| aBoardGame firstPlayer secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdPlayer fourthPlayer secondPlayer thirdDice aDiceCup aSpinNumber |
	firstPlayer := Player called: 'Pau'.
	secondPlayer := Player called: 'Male'.
	thirdPlayer := Player called: 'Belu'.
	fourthPlayer := Player called: 'Juli'.
	firstDice := DeterministicDice with: #(2 4 7 2).
	secondDice := DeterministicDice with: #(8 5 4 7 2).
	thirdDice := DeterministicDice with: #(4 1 2 7 2).
	aGroupOfPlayers := {firstPlayer.  secondPlayer . thirdPlayer . fourthPlayer}.
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
	
	self assert: (aBoardGame findPlayersRanking ) equals: (OrderedCollection newFrom: (#('1) Pau: 21' '2) Juli: 17' '3) Belu: 14' '4) Male: 11'))).
	 
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

{ #category : #accessingTests }
BoardGameTest >> testABoardGameHasARanking [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame findPlayersRanking equals: (OrderedCollection newFrom: {'1) Pau: 20'}).
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
	| paula aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge aSpinNumber |
	paula := Player called: 'Pau'.
	jorge := Player called: 'Jorge'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {paula. jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 11.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 1.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 1.
	aBoardGame nextTurn.
	self deny: aBoardGame isFinished.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 3.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 1.
	aBoardGame nextTurn.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 3.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 5.
	aBoardGame nextTurn.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 10.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 5.
	aBoardGame nextTurn.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 10.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 8.
	aBoardGame nextTurn.
	self assert: (aBoardGame findInWhichPositionIs: paula) equals: 11.
	self assert: (aBoardGame findInWhichPositionIs: jorge) equals: 8.
	self assert: aBoardGame winner equals: paula
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

{ #category : #positionTest }
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

{ #category : #positionTest }
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

{ #category : #circularBoardTest }
BoardGameTest >> testABoardGameKnowsInWhichSpinItIs [
	| aPlayer aDice aGroupOfPlayers aGroupOfDices aNumberOfFields aDiceCup aBoardGame aSpinNumber |
	aPlayer := Player called: 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 20.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aSpinNumber:=1.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	self assert: (aBoardGame knowsInWhichSpinIs: aPlayer) identicalTo: 1.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: (aBoardGame knowsInWhichSpinIs: aPlayer) identicalTo: 2.	
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame findPlayersRanking) equals: (OrderedCollection newFrom: #('1) Pau: 1')).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame findPlayersRanking) equals: (OrderedCollection newFrom: #('1) Pau: 3')).
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup aSpinNumber |
	aPlayer:= Player called: 'Pau'.
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
	
	self assert: (aBoardGame findPlayersRanking) equals: (OrderedCollection newFrom: #('1) Pau: 25'))..
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

{ #category : #circularBoardTest }
BoardGameTest >> testAPlayerMustGoThreeTimesAroundTheBoardToWin [
	| aPlayer aDice aGroupOfPlayers aGroupOfDices aNumberOfFields aDiceCup aBoardGame aSpinNumber |
	aPlayer := Player called: 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 20.
	aSpinNumber := 3.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aBoardGame := BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame findPlayersRanking equals: (OrderedCollection newFrom: {'1) Pau: 20'}).	
]

{ #category : #accessingTests }
BoardGameTest >> testTheBoardGameHas20Fields [
 			
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame numberOfFields) equals: 20.
]

{ #category : #circularBoardTest }
BoardGameTest >> testTheBoardIsCircular [
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	self assert: aBoardGame findPlayersRanking equals: (OrderedCollection newFrom: {'1) Pau: 3'}).
]
