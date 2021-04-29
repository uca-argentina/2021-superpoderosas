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
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields [ 
		^ self new initializeWith: aGroupOfPlayers and: aDiceCup playedOnABoardwith: aNumberOfFields.
]

{ #category : #accessing }
BoardGame >> actualPositionsOfPlayers [
	^ (self groupOfPlayersSortedInAscendingOrderByActualPosition)  
	     collect: [:aPlayer | aPlayer nameAndActualPosition ].
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #private }
BoardGame >> determinateNewPositionWith: aNumberOfFieldsToMoveAlong and: aPositionOnTheBoard [
	| newPlayerPosition |
	newPlayerPosition := (self numberOfFields) min:(aNumberOfFieldsToMoveAlong + aPositionOnTheBoard).
	self verifyIfTheFinishingMarkIsAt: newPlayerPosition.
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
	self verifyIsNotEmpty: aGroupOfPlayers .
	
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

{ #category : #validations }
BoardGame >> verifyIfTheFinishingMarkIsAt: aPosition [ 
	(aPosition = numberOfFields) ifTrue:[self changeCurrentStateToFinished].
]

{ #category : #validations }
BoardGame >> verifyIfTheGameHasFinished [
	(isFinished) 
		ifTrue: [ Error signal: (self class) errorMessageTheGameHasFinished] .
]

{ #category : #validations }
BoardGame >> verifyIfTheGameIsInProcess [
	(isFinished not) 
		ifTrue: [ Error signal: (self class) errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #validations }
BoardGame >> verifyIsNotEmpty: aGroupOfPlayers [ 
	
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: (self class) errorMessageMustHaveAtLeastAPlayer ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameIsInProcess.	
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
