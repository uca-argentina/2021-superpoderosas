Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testABoardGameCanDistinguishBetweenWhoseTurnIsIt [
 		
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
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	1 to: 5 do: [ :n | aBoardGame nextTurn ].
	
	
	self assert: (aBoardGame actualPositionsOfPlayers ) equals: #('Pau: 20' 'Juli: 16' 'Belu: 13' 'Male: 10').
	 
]

{ #category : #tests }
GameTest >> testABoardGameCanHaveFourPlayers [
 		
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
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aGroupOfDices playedOnABoardwith: aNumberOfFields .
	
	self assert: (aBoardGame players size) identicalTo: 4.
	
]

{ #category : #tests }
GameTest >> testABoardGameDoesntHaveAWinnerYet [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	aBoardGame nextTurn.
	
	self 
		should:[aBoardGame winner] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageDoesNotHaveAWinnerYet  ].
]

{ #category : #tests }
GameTest >> testABoardGameHasARanking [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame playersRanking) equals: {'1: Pau'}.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinished [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame currentState) equals: 'Finished'.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndHasAWinner [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self assert: (aBoardGame winner) equals: aPlayer.
]

{ #category : #tests }
GameTest >> testABoardGameHasFinishedAndPlayersMustBeHalted [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	1 to: 6 do: [ :n | aBoardGame nextTurn ].
	
	self 
		should:[aBoardGame nextTurn] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: BoardGame errorMessageTheGameHasFinished  ].
]

{ #category : #tests }
GameTest >> testABoardGameHasOnePlayer [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aGroupOfDices playedOnABoardwith: aNumberOfFields .
	
	self assert: (aBoardGame numberOfPlayers) identicalTo: 1.
]

{ #category : #tests }
GameTest >> testABoardGameIsInProcess [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aGroupOfDices playedOnABoardwith: aNumberOfFields .
	
	self assert: (aBoardGame currentState) equals: 'In Process'.
]

{ #category : #tests }
GameTest >> testABoardGameKnowsThePlayersPosition [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields |
	aPlayer:= Player called: 'Pau'.
	aGroupOfPlayers:= {aPlayer}.
	aDice:= DeterministicDice with:#(2 4 7 3).
	aGroupOfDices := { aDice }.
	aNumberOfFields:= 20.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aGroupOfDices playedOnABoardwith: aNumberOfFields .
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 0').
]

{ #category : #tests }
GameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowADiceAndMoveOnTheBoard [
 		
	| aPlayer aBoardGame aGroupOfPlayers aDice aGroupOfDices aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	aDice:= DeterministicDice with: #(2 4 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { aDice }.
	aNumberOfFields:= 20.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	aBoardGame nextTurn.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 2').
]

{ #category : #tests }
GameTest >> testABoardGameMakesThePlayerWhoseTurnItIsThrowThreeDicesSimultaneously [
 		
	| aPlayer aBoardGame aGroupOfPlayers aGroupOfDices firstDice secondDice thirdDice aNumberOfFields aDiceCup |
	aPlayer:= Player called: 'Pau'.
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfPlayers:= {aPlayer}.
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aNumberOfFields:= 50.
	aDiceCup:= DiceCup containing: aGroupOfDices.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields .
	aBoardGame nextTurn.
	aBoardGame nextTurn.
	
	self assert: (aBoardGame actualPositionsOfPlayers) equals: #('Pau: 24').
]

{ #category : #'test - aPlayer' }
GameTest >> testAPlayerHasACertainName [
 
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer name) equals: 'Pau'.
]

{ #category : #'test - aPlayer' }
GameTest >> testAPlayerHasAnInitialPositionOnTheBoardGame [
 		
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer actualPosition) identicalTo: 0.
]

{ #category : #'test - aDice' }
GameTest >> testARandomDiceHas6Faces [	
	| aRandomDice |
	aRandomDice:= RandomDice with: 6.		
	self assert: (aRandomDice hasNFaces: 6).
]

{ #category : #'test - aDice' }
GameTest >> testARandomDiceHasAtLeastTwoFaces [	
	| aRandomDice anotherRandomDice |
	aRandomDice:= RandomDice with: 0.	
	anotherRandomDice:= RandomDice with: 1.	
	self assert: ((aRandomDice hasNFaces: 2) and:(anotherRandomDice hasNFaces: 2)) .

]

{ #category : #tests }
GameTest >> testTheBoardGameHas26Fields [
 			
	|  aGroupOfPlayers aGroupOfDices aNumberOfFields aBoardGame |
	aGroupOfPlayers:= {}.
	aGroupOfDices:= {}.
	aNumberOfFields:= 26.
	aBoardGame:= BoardGame with: aGroupOfPlayers and: aGroupOfDices playedOnABoardwith: aNumberOfFields .
	self assert: (aBoardGame numberOfFields) equals: aNumberOfFields.
]

{ #category : #'test - aDice' }
GameTest >> testWhenThrowingADeterministicDiceWeGet2 [
 	| obtainedValue aDeterministicDice aPattern |
	"mas adelante agregar un bloque con un patron"
	aPattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: aPattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.
]

{ #category : #'test - aDice' }
GameTest >> testWhenThrowingADeterministicDiceWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: pattern.
	1 to:8 do:
			[ :index | obtainedValue:= aDeterministicDice throw. 
			self assert: obtainedValue identicalTo: (#(2 3 4 1 1 6 5 2) at:index)].
	
	

	
]

{ #category : #'test - aDice' }
GameTest >> testWhenThrowingARandomDiceWith6FacesWeCanGetAValueBetween1and6 [
 	| obtainedValue aRandomDice |
	aRandomDice:= RandomDice with: 6.
	obtainedValue:= aRandomDice throw.		
	self assert: (obtainedValue between: 1 and:6).
]
