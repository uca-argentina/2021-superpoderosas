Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'numberOfFields',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields [ 
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields.
]

{ #category : #accessing }
BoardGame >> actualPositionsOfPlayers [
	^ (self groupOfPlayersSortedInAscendingOrderByActualPosition)  
	     collect: [:aPlayer | aPlayer nameAndActualPosition ].
]

{ #category : #private }
BoardGame >> addOneToPlayersTurnIdentificator [
	playersTurnIdentificator := playersTurnIdentificator +1.
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #private }
BoardGame >> determinateNewPositionBasedOn: aNumberOfFieldsToMoveAlong and: aPositionOnTheBoard [
	| newPlayerPosition |
	newPlayerPosition := (self numberOfFields) min:(aNumberOfFieldsToMoveAlong + aPositionOnTheBoard).
	self verifyIfTheFinishLineIsAt: newPlayerPosition.
	^ newPlayerPosition.
	
]

{ #category : #'error messages' }
BoardGame >> errorMessageDoesNotHaveAWinnerYet [
	^ 'The board game has not finished yet, so it does not have a winner.'.
]

{ #category : #'error messages' }
BoardGame >> errorMessageMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame >> errorMessageTheGameHasFinished [
	^ 'The board game has already finished, contestants can not play anymore.'.
]

{ #category : #private }
BoardGame >> groupOfPlayersSortedInAscendingOrderByActualPosition [
	^ players sort: [ :onePlayer :anotherPlayer | onePlayer actualPosition > anotherPlayer actualPosition ].
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	numberOfFields :=aNumberOfFields.
	isFinished := false.
	playersTurnIdentificator := 1.
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| aPlayer |
	self verifyIfTheGameHasFinished.
	aPlayer:= players at: playersTurnIdentificator.
	aPlayer throw: diceCup movingOn: self.
	self updatePlayersTurnIdentificator. 
	
]

{ #category : #accessing }
BoardGame >> numberOfFields [
	^ numberOfFields
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #private }
BoardGame >> originalPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #actions }
BoardGame >> playersRanking [
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition  withIndexCollect: [:aPlayer :anIndex | self textWith: anIndex andTheNameOf: aPlayer ].
]

{ #category : #private }
BoardGame >> textWith: aRank andTheNameOf: aPlayer [ 
	^ (aRank asString , ': ' , aPlayer name ).
]

{ #category : #private }
BoardGame >> updatePlayersTurnIdentificator [
	(self validateIfPlayersTurnIdentificatorHasToBeTheOriginal)
        ifTrue: [ self originalPlayersTurnIdentificator]
        ifFalse: [ self addOneToPlayersTurnIdentificator].
]

{ #category : #private }
BoardGame >> validateIfPlayersTurnIdentificatorHasToBeTheOriginal [
	^ playersTurnIdentificator= self numberOfPlayers .
]

{ #category : #validations }
BoardGame >> verifyIfItIsNotEmpty: aGroupOfPlayers [ 
	
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastAPlayer ] .
]

{ #category : #validations }
BoardGame >> verifyIfTheFinishLineIsAt: aPosition [ 
	(aPosition = numberOfFields) ifTrue:[self changeCurrentStateToFinished].
]

{ #category : #validations }
BoardGame >> verifyIfTheGameHasFinished [
	(isFinished) 
		ifTrue: [ Error signal: self errorMessageTheGameHasFinished] .
]

{ #category : #validations }
BoardGame >> verifyIfTheGameIsInProcess [
	(isFinished not) 
		ifTrue: [ Error signal: self errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameIsInProcess.	
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
