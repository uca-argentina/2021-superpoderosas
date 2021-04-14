Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testABoardGameCanHaveFourPlayers [
 		
	|aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice firstPlayer secondPlayer thirdPlayer fourthPlayer aNumberOfFields |
	firstPlayer:= Player called: 'Pau'.
	secondPlayer:= Player called: 'Male'.
	thirdPlayer:= Player called: 'Belu'.
	fourthPlayer:= Player called: 'Juli'.
	firstDice:= DeterministicDice determinedBy:#(2 4 7 2).
	secondDice:= DeterministicDice determinedBy:#(8 5 4 7 2).
	thirdDice:= DeterministicDice determinedBy:#(4 1 2 7 2).
	aGroupOfPlayers:= {firstPlayer. secondPlayer. thirdPlayer. fourthPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	
	self assert: (aBoardGame players size) identicalTo: 4.
	
]

{ #category : #tests }
GameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageDoesNotHaveAWinnerYet  ].
]

{ #category : #tests }
GameTest >> testABoardGameHasFinished [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame winner) equals: aPlayer.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndHasARankingOfPlayers [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame playersRanking) equals: {'1: Pau'}.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndHasAWinner [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame winner) equals: aPlayer.
]

{ #category : #tests }
GameTest >> testABoardGameHasOnePlayer [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	
	self assert: (aBoardGame players size) identicalTo: 1.
]

{ #category : #tests }
GameTest >> testABoardGameIsInProcess [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	
	self assert: (aBoardGame currentState) equals: 'In Process'.
]

{ #category : #tests }
GameTest >> testABoardGameIsPlayedByFourPlayersAndCanDistinguishBetweenWhoseTurnIsIt [
 		
	|aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice firstPlayer secondPlayer thirdPlayer fourthPlayer aNumberOfFields |
	firstPlayer:= Player called: 'Pau'.
	secondPlayer:= Player called: 'Male'.
	thirdPlayer:= Player called: 'Belu'.
	fourthPlayer:= Player called: 'Juli'.
	firstDice:= DeterministicDice determinedBy:#(2 4 7 2).
	secondDice:= DeterministicDice determinedBy:#(8 5 4 7 2).
	thirdDice:= DeterministicDice determinedBy:#(4 1 2 7 2).
	aGroupOfPlayers:= {firstPlayer. secondPlayer. thirdPlayer. fourthPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	
	
	self assert: (aBoardGame positionOfPlayers ) equals: #('Pau: 20' 'Juli: 16' 'Belu: 13' 'Male: 10').
	 
]

{ #category : #tests }
GameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	
	self assert: (aBoardGame positionOfPlayers) equals: #('Pau: 0').
]

{ #category : #tests }
GameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices aDice aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	aBoardGame nextTurn.
	
	self assert: (aBoardGame positionOfPlayers) equals: #('Pau: 2').
]

{ #category : #tests }
GameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	firstDice:= DeterministicDice determinedBy:#(2 4 7 2).
	secondDice:= DeterministicDice determinedBy:#(8 5 4 7 2).
	thirdDice:= DeterministicDice determinedBy:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame positionOfPlayers) equals: #('Pau: 24').
]

{ #category : #tests }
GameTest >> testAPlayerHasACertainName [
 
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer name) equals: 'Pau'.
]

{ #category : #tests }
GameTest >> testAPlayerHasAnInitialPositionOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	
	self assert: (aBoardGame positionOfPlayers) equals: (OrderedDictionary newFromKeys: {aPlayer} andValues: {0}).
]

{ #category : #tests }
GameTest >> testARandomDiceHas6Faces [	
	| aRandomDice |
	aRandomDice:= RandomDice withNFaces: 6.		
	self assert: (aRandomDice hasNFaces: 6).
]

{ #category : #tests }
GameTest >> testTheBoardHas26Fields [
 
	| aGroupOfPlayers aGroupOfDices aBoardGame anNumberOfFields |
	aGroupOfPlayers:= {}.
	aGroupOfDices:= {}.
	anNumberOfFields:= 26.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: anNumberOfFields.
	self assert: (aBoardGame numberOfFields) identicalTo: 26.
]

{ #category : #tests }
GameTest >> testWhenAPlayerThrowsFiveTimesADeterministicDiceChangesPositionOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 5 do: [ :n | aPlayer isYourTurnToPlayWith: aGroupOfDices ].
	
	self assert: (aBoardGame positionOfPlayers) equals: #('Pau: 18').
]

{ #category : #tests }
GameTest >> testWhenAPlayerThrowsOneDiceAndMovesAlongTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice determinedBy:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
	1 to: 5 do: [:n |aBoardGame nextTurn].
	self assert: (aBoardGame positionOfPlayers) equals: (OrderedDictionary newFromKeys: {aPlayer} andValues: {18}).
	
	
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGet2 [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice determinedBy: pattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice determinedBy: pattern.
	1 to:8 do:
			[ :index | obtainedValue:= aDeterministicDice throw. 
			self assert: obtainedValue identicalTo: (#(2 3 4 1 1 6 5 2) at:index)].
	
	

	
]

{ #category : #tests }
GameTest >> testWhenThrowingARandomDiceWith6FacesWeCanGetAValueBetween1and6 [
 	| obtainedValue aRandomDice |
	aRandomDice:= RandomDice withNFaces: 6.
	obtainedValue:= aRandomDice throw.		
	self assert: (obtainedValue between: 1 and:6).
]
