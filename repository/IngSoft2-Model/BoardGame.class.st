Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'currentState',
		'board',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageDoesNotHaveAWinnerYet [
	^ 'The board game has not finished yet, so it does not have a winner.'.
]

{ #category : #initialization }
BoardGame class >> withPlayers: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices [ 
		^ self new initializeWith: aGroupOfPlayers playedOn: aBoard with: aGroupOfDices .
]

{ #category : #characterizing }
BoardGame >> actualPositionsOfPlayers [
	^ (self groupOfPlayersSortedInAscendingOrderByActualPosition)  
	     collect: [:aPlayer | aPlayer reportNameAndActualPosition ].
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

{ #category : #initialize }
BoardGame >> initializeWith: aGroupOfPlayers  playedOn: aBoard with: aGroupOfDices [ 
	dices := aGroupOfDices.
	players := aGroupOfPlayers.
	board := aBoard.
	currentState := 'In Process'.
]

{ #category : #actions }
BoardGame >> notifyPlayerTurnAndChangeStatusIfNecessary [
	(players first) isYourTurnToPlayWith: dices.
	self changeCurrentStateIfNecessary: (players first).
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #actions }
BoardGame >> playersRanking [
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition  withIndexCollect: [:aPlayer :anIndex | self textWithRanking: anIndex andNameOf: aPlayer ].
]

{ #category : #actions }
BoardGame >> textWithRanking: aRank andNameOf: aPlayer [ 
	^ (aRank asString , ': ' , aPlayer name ).
]

{ #category : #actions }
BoardGame >> verifyIfTheGameHasFinish [
	(currentState = 'In Process') 
		ifTrue: [ Error signal: super errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameHasFinish.
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
