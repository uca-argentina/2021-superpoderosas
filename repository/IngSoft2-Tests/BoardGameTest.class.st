Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardGameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
	|aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice firstPlayer secondPlayer thirdPlayer fourthPlayer aNumberOfFields aDiceCup |
	firstPlayer:= Player called: 'Pau'.
	secondPlayer:= Player called: 'Male'.
	thirdPlayer:= Player called: 'Belu'.
	fourthPlayer:= Player called: 'Juli'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {firstPlayer. secondPlayer. thirdPlayer. fourthPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aNumberOfFields:= 50.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	
	
	self assert: (aBoardGame actualPositionsOfPlayers ) equals: #('Pau: 20' 'Juli: 16' 'Belu: 13' 'Male: 10').
	 
]

{ #category : #tests }
BoardGameTest >> testABoardGameCanHaveFourPlayers [
 		
	|aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice firstPlayer secondPlayer thirdPlayer fourthPlayer aNumberOfFields |
	firstPlayer:= Player called: 'Pau'.
	secondPlayer:= Player called: 'Male'.
	thirdPlayer:= Player called: 'Belu'.
	fourthPlayer:= Player called: 'Juli'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {firstPlayer. secondPlayer. thirdPlayer. fourthPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aGroupOfDices onABoardOf: aNumberOfFields .
	
	self assert: (aBoardGame players size) identicalTo: 4.
	
]

{ #category : #tests }
BoardGameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageDoesNotHaveAWinnerYet  ].
]

{ #category : #tests }
BoardGameTest >> testABoardGameHasARanking [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame playersRanking) equals: {'1: Pau'}.
]

{ #category : #tests }
BoardGameTest >> testABoardGameHasFinished [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame isFinished).
]

{ #category : #tests }
BoardGameTest >> testABoardGameHasFinishedAndHasAWinner [
	| paula aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup jorge |
	paula := Player called: 'Pau'.
	jorge := Player called: 'Jorge'.
	aDice := DeterministicDice with: #(2 4 7 3).
	aGroupOfPlayers := {paula.
	jorge}.
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

{ #category : #tests }
BoardGameTest >> testABoardGameHasFinishedAndPlayersMustBeHalted [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageTheGameHasFinished  ].
]

{ #category : #tests }
BoardGameTest >> testABoardGameHasOnePlayer [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aGroupOfDices onABoardOf: aNumberOfFields .
	
	self assert: (aBoardGame numberOfPlayers) identicalTo: 1.
]

{ #category : #tests }
BoardGameTest >> testABoardGameIsInProcess [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aGroupOfDices onABoardOf: aNumberOfFields .
	
	self deny: (aBoardGame isFinished).
]

{ #category : #tests }
BoardGameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aGroupOfDices onABoardOf: aNumberOfFields .
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 0').
]

{ #category : #tests }
BoardGameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with: #(2 4 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields .
	aBoardGame nextTurn.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 2').
]

{ #category : #tests }
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

{ #category : #tests }
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
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageMustHaveAtLeastAPlayer].
]

{ #category : #tests }
BoardGameTest >> testTheBoardGameHas26Fields [
 			
	|  aGroupOfPlayers aGroupOfDices aNumberOfFields aBoardGame aPlayer aDice |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 26.
	aBoardGame:= BoardGame playedBy: aGroupOfPlayers using: aGroupOfDices onABoardOf: aNumberOfFields .
	self assert: (aBoardGame numberOfFields) equals: aNumberOfFields.
]
