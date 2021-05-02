Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithASinglePlayer [
	| aGroupOfDices aPlayer aDiceCup aNumberOfFields aDice aBoardGame aGroupOfPlayers |
	aPlayer := Player called: 'Pau'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {aPlayer}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 20.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		onABoardOf: aNumberOfFields.
	^ aBoardGame
]

{ #category : #accessingTests }
BoardGameTest >> newBoardGameWithMultiplePlayers [
	| aBoardGame firstPlayer secondDice aGroupOfPlayers aGroupOfDices firstDice aNumberOfFields thirdPlayer fourthPlayer secondPlayer thirdDice aDiceCup |
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
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		onABoardOf: aNumberOfFields.
		
	^ aBoardGame
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithMultiplePlayers.
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame actualPositionsOfPlayers ) equals: #('Pau: 20' 'Juli: 16' 'Belu: 13' 'Male: 10').
	 
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
	self assert: aBoardGame playersRanking equals: {'1: Pau'}
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
	| paula aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge |
	paula := Player called: 'Pau'.
	jorge := Player called: 'Jorge'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {paula. jorge}.
	aGroupOfDices := {aDice}.
	aNumberOfFields := 10.
	aDiceCup := DiceCup containing: aGroupOfDices.
	aBoardGame := BoardGame
		playedBy: aGroupOfPlayers
		using: aDiceCup
		onABoardOf: aNumberOfFields.
	self assert: paula actualPosition equals: 0.
	self assert: jorge actualPosition equals: 0.
	aBoardGame nextTurn.
	self deny: aBoardGame isFinished.
	self assert: paula actualPosition equals: 2.
	self assert: jorge actualPosition equals: 0.
	aBoardGame nextTurn.
	self assert: paula actualPosition equals: 2.
	self assert: jorge actualPosition equals: 4.
	aBoardGame nextTurn.
	self assert: paula actualPosition equals: 9.
	self assert: jorge actualPosition equals: 4.
	aBoardGame nextTurn.
	self assert: paula actualPosition equals: 9.
	self assert: jorge actualPosition equals: 7.
	aBoardGame nextTurn.
	self assert: paula actualPosition equals: 10.
	self assert: jorge actualPosition equals: 7.
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

{ #category : #statusTests }
BoardGameTest >> testABoardGameIsInProcess [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self deny: (aBoardGame isFinished).
]

{ #category : #accessingTests }
BoardGameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 0').
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 2').
]

{ #category : #playingTests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 24').
]

{ #category : #validationTests }
BoardGameTest >> testABoardGameNeedsAtLeastOnePlayer [
 		
	|aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.

	self 
		should:[BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The board game must have at leaste ONE player'].
]

{ #category : #accessingTests }
BoardGameTest >> testTheBoardGameHas20Fields [
 			
	| aBoardGame |
	aBoardGame := self newBoardGameWithASinglePlayer.
	
	self assert: (aBoardGame numberOfFields) equals: 20.
]
