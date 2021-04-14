Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'currentState',
		'board',
		'dices',
		'playersTurnIdentificator',
		'numberOfFields',
		'positionOfPlayers',
		'playersPosition'
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

{ #category : #actions }
BoardGame >> changeCurrentStateIfNecessary: aPlayer [ 
	( (playersPosition at: aPlayer) = numberOfFields )
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
	playersPosition := OrderedDictionary newFromKeys: aGroupOfPlayers andValues: (OrderedCollection new: aGroupOfPlayers size withAll: 0).
	currentState := 'In Process'.
	playersTurnIdentificator := 1.
	numberOfFields:= aNumberOfFields.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| aPlayer aNumberOfFields |
	aPlayer:= playersPosition keyAtIndex: playersTurnIdentificator.
	aNumberOfFields:= aPlayer isYourTurnToPlayWith: dices. 
	self update: aPlayer positionAdding: aNumberOfFields.
	self changeCurrentStateIfNecessary: aPlayer.
	self updatePlayersTurnIdentificator. 
]

{ #category : #Characterizing }
BoardGame >> numberOfFields [
	^ numberOfFields
]

{ #category : #characterizing }
BoardGame >> players [
	^ players
]

{ #category : #actions }
BoardGame >> playersRanking [
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition  withIndexCollect: [:aPlayer :anIndex | self textWithRanking: anIndex andNameOf: aPlayer ].
]

{ #category : #characterizing }
BoardGame >> positionOfPlayers [
	^ playersPosition .
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
BoardGame >> update: aPlayer positionAdding: aNumberOfFields [ 
	| actualPosition |
	actualPosition:= playersPosition at: aPlayer.
	playersPosition at: aPlayer put: aNumberOfFields + actualPosition.
]

{ #category : #'as yet unclassified' }
BoardGame >> updateAPlayersPosition: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #actions }
BoardGame >> updatePlayersTurnIdentificator [
	(self validateIfPlayersTurnIdentificatorNeedsToBeUpdated)
		ifTrue: [ self restartPlayersTurnIdentificator]
		ifFalse: [ self incrementByOnePlayersTurnIdentificator].
		
	
]

{ #category : #actions }
BoardGame >> validateIfPlayersTurnIdentificatorNeedsToBeUpdated [
	^ playersTurnIdentificator= playersPosition size.
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
