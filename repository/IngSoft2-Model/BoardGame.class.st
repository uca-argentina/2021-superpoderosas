Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'currentState',
		'board',
		'dices',
		'playersTurnIdentificator',
		'numberOfFields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageDoesNotHaveAWinnerYet [
	^ 'The board game has not finished yet, so it does not have a winner.'.
]

{ #category : #initialization }
BoardGame class >> withPlayers: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields [ 
		^ self new initializeWith: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields .
]

{ #category : #characterizing }
BoardGame >> actualPositionsOfPlayers [
	^ board actualPositionsOfPlayers.
]

{ #category : #actions }
BoardGame >> changeCurrentStateIfNecessary: aPlayer [ 
	( aPlayer actualPosition > board amountOfFields )
		ifTrue: [ self changeCurrentStateToFinished ].
]

{ #category : #actions }
BoardGame >> changeCurrentStateToFinished [
	currentState := 'Finished'.
]

{ #category : #characterizing }
BoardGame >> currentState [
	^ currentState.
]

{ #category : #actions }
BoardGame >> groupOfPlayersSortedInAscendingOrderByActualPosition [
	^ players sort: [ :onePlayer :anotherPlayer | onePlayer actualPosition > anotherPlayer actualPosition ].
]

{ #category : #actions }
BoardGame >> incrementByOnePlayersTurnIdentificator [
	playersTurnIdentificator:= playersTurnIdentificator +1.
]

{ #category : #initialize }
BoardGame >> initializeWith: aGroupOfPlayers with: aGroupOfDices onABoardWith: aNumberOfFields [
	dices := aGroupOfDices.
	players := aGroupOfPlayers.
	currentState := 'In Process'.
	playersTurnIdentificator := 1.
	numberOfFields:= aNumberOfFields.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| aPlayer |
	aPlayer:= players at: playersTurnIdentificator.
	aPlayer isYourTurnToPlayWith: dices.
	self changeCurrentStateIfNecessary: aPlayer.
	self updatePlayersTurnIdentificator. 
]

{ #category : #Characterizing }
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

{ #category : #actions }
BoardGame >> restartPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #actions }
BoardGame >> textWithRanking: aRank andNameOf: aPlayer [ 
	^ (aRank asString , ': ' , aPlayer name ).
]

{ #category : #actions }
BoardGame >> updatePlayersTurnIdentificator [
	(self validateIfPlayersTurnIdentificatorNeedsToBeUpdated)
		ifTrue: [ self restartPlayersTurnIdentificator]
		ifFalse: [ self incrementByOnePlayersTurnIdentificator].
		
	
]

{ #category : #actions }
BoardGame >> validateIfPlayersTurnIdentificatorNeedsToBeUpdated [
	^ playersTurnIdentificator= players size.
]

{ #category : #actions }
BoardGame >> verifyIfTheGameHasFinish [
	(currentState = 'In Process') 
		ifTrue: [ Error signal: (self class) errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameHasFinish.
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
