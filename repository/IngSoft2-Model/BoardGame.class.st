Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'currentState',
		'playersTurnIdentificator',
		'numberOfFields',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageDoesNotHaveAWinnerYet [
	^ 'The board game has not finished yet, so it does not have a winner.'.
]

{ #category : #'error messages' }
BoardGame class >> errorMessageMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame class >> errorMessageTheGameHasFinished [
	^ 'The board game has already finished, contestants can not play anymore .'.
]

{ #category : #initialization }
BoardGame class >> with: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields [ 
		^ self new initializeWith: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields.
]

{ #category : #characterizing }
BoardGame >> actualPositionsOfPlayers [
	^ (self groupOfPlayersSortedInAscendingOrderByActualPosition)  
	     collect: [:aPlayer | aPlayer reportNameAndActualPosition ].
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	currentState := 'Finished'.
]

{ #category : #characterizing }
BoardGame >> currentState [
	^ currentState.
]

{ #category : #private }
BoardGame >> determinateNewPositionWith: aNumberOfFieldsToMoveAlong and: aPositionOnTheBoard [
	| newPlayerPosition |
	newPlayerPosition := (self numberOfFields) min:(aNumberOfFieldsToMoveAlong + aPositionOnTheBoard).
	self verifyIfThePlayerHasWon: newPlayerPosition.
	^ newPlayerPosition.
	
]

{ #category : #private }
BoardGame >> groupOfPlayersSortedInAscendingOrderByActualPosition [
	^ players sort: [ :onePlayer :anotherPlayer | onePlayer actualPosition > anotherPlayer actualPosition ].
]

{ #category : #private }
BoardGame >> incrementByOnePlayersTurnIdentificator [
	playersTurnIdentificator:= playersTurnIdentificator +1.
]

{ #category : #initialize }
BoardGame >> initializeWith: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields [
	self verifyIsNotEmpty: aGroupOfPlayers  .
	
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	numberOfFields :=aNumberOfFields.
	currentState := 'In Process'.
	playersTurnIdentificator := 1.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| aPlayer |
	self verifyIfTheGameHasFinished.
	aPlayer:= players at: playersTurnIdentificator.
	aPlayer isYourTurnToThrow: diceCup andMoveAlong: self.
	self updatePlayersTurnIdentificator. 
	
]

{ #category : #characterizing }
BoardGame >> numberOfFields [
	^ numberOfFields
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #characterizing }
BoardGame >> players [
	^ players
]

{ #category : #actions }
BoardGame >> playersRanking [
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition  withIndexCollect: [:aPlayer :anIndex | self textWithRanking: anIndex andNameOf: aPlayer ].
]

{ #category : #private }
BoardGame >> restartPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #private }
BoardGame >> textWithRanking: aRank andNameOf: aPlayer [ 
	^ (aRank asString , ': ' , aPlayer name ).
]

{ #category : #private }
BoardGame >> updatePlayersTurnIdentificator [
	(self validateIfPlayersTurnIdentificatorNeedsToBeUpdated)
		ifTrue: [ self restartPlayersTurnIdentificator]
		ifFalse: [ self incrementByOnePlayersTurnIdentificator].
		
	
]

{ #category : #private }
BoardGame >> validateIfPlayersTurnIdentificatorNeedsToBeUpdated [
	^ playersTurnIdentificator= self numberOfPlayers .
]

{ #category : #exceptions }
BoardGame >> verifyIfTheGameHasFinished [
	(currentState = 'Finished') 
		ifTrue: [ Error signal: (self class) errorMessageTheGameHasFinished] .
]

{ #category : #exceptions }
BoardGame >> verifyIfTheGameIsInProcess [
	(currentState = 'In Process') 
		ifTrue: [ Error signal: (self class) errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #private }
BoardGame >> verifyIfThePlayerHasWon: aPosition [ 
	(aPosition = numberOfFields) ifTrue:[self changeCurrentStateToFinished].
]

{ #category : #exceptions }
BoardGame >> verifyIsNotEmpty: aGroupOfPlayers [ 
	
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: (self class) errorMessageMustHaveAtLeastAPlayer ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameIsInProcess.	
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
