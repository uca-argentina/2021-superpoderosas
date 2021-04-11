Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	aBoardGame notifyPlayerTurnAndChangeStatusIfNecessary.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageDoesNotHaveAWinnerYet  ].
]

{ #category : #tests }
GameTest >> testABoardGameHasFinished [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	1 to: 6 do: [ :n | aBoardGame notifyPlayerTurnAndChangeStatusIfNecessary ].
	
	self assert: (aBoardGame winner) equals: aPlayer.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndHasARankingOfPlayers [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	1 to: 6 do: [ :n | aBoardGame notifyPlayerTurnAndChangeStatusIfNecessary ].
	
	self assert: (aBoardGame playersRanking) equals: {'1: Pau'}.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndHasAWinner [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	1 to: 6 do: [ :n | aBoardGame notifyPlayerTurnAndChangeStatusIfNecessary ].
	
	self assert: (aBoardGame winner) equals: aPlayer.
]

{ #category : #tests }
GameTest >> testABoardGameHasOnePlayer [
 		
	| aPlayer aBoardGame aGroupOfPlayers aBoard aDice aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= #(aPlayer).
	aBoard:= Board withAnAmountOfFields: 20.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	
	self assert: (aBoardGame numberOfPlayers) identicalTo: 1.
]

{ #category : #tests }
GameTest >> testABoardGameIsInProcess [
 		
	| aPlayer aBoardGame aGroupOfPlayers aBoard aDice aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	
	self assert: (aBoardGame currentState) equals: 'In Process'.
]

{ #category : #tests }
GameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aPlayer aBoardGame aGroupOfPlayers aBoard aDice aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 0').
]

{ #category : #tests }
GameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices:= { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	aBoardGame notifyPlayerTurnAndChangeStatusIfNecessary.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 2').
]

{ #category : #tests }
GameTest >> testADeterministicDiceHas6Faces [	
	| aDeterministicDice |
	aDeterministicDice:= DeterministicDice withNFaces: 6.		
	self assert: (aDeterministicDice hasNFaces: 6).
]

{ #category : #tests }
GameTest >> testAPlayerHasACertainName [
 
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer name) equals: 'Pau'.
]

{ #category : #tests }
GameTest >> testAPlayerHasAnInitialPositionOnTheBoardGame [
 		
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer actualPosition) identicalTo: 0.
]

{ #category : #tests }
GameTest >> testARandomDiceHas6Faces [	
	| aRandomDice |
	aRandomDice:= RandomDice withNFaces: 6.		
	self assert: (aRandomDice hasNFaces: 6).
]

{ #category : #tests }
GameTest >> testTheBoardHas26Fields [
 			
	| aBoard |
	aBoard:= Board withAnAmountOfFields: 26. 
	self assert: (aBoard amountOfFields) identicalTo: 26.
]

{ #category : #tests }
GameTest >> testWhenAPlayerThrowsFiveTimesADeterministicDiceChangesPositionOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	1 to: 5 do: [ :n | aPlayer isYourTurnToPlayWith: aGroupOfDices ].
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 18').
]

{ #category : #tests }
GameTest >> testWhenAPlayerThrowsOneTimeADeterministicDiceChangesPositionOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aBoard aGroupOfDices |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice newDiceWithNFaces: 7 andPattern:#(2 4 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aBoard:= Board withAnAmountOfFields: 20.
	aGroupOfDices := { aDice }.
	aBoardGame:= BoardGame withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices.
	aPlayer isYourTurnToPlayWith: aGroupOfDices.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 2').
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGet2 [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice newDiceWithNFaces: 6 andPattern: pattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice newDiceWithNFaces: 6 andPattern: pattern.
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
