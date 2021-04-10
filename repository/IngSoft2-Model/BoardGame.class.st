Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> withPlayers: aGroupOfPlayers [
	^ self new initializeWith: aGroupOfPlayers .
]

{ #category : #actions }
BoardGame >> actualPositionsOfPlayers [
	^ players collect: [:aPlayer | aPlayer reportNameAndActualPosition ].
]

{ #category : #initalize }
BoardGame >> initializeWith: aGroupOfPlayers [
	players:= aGroupOfPlayers.
]

{ #category : #characterizing }
BoardGame >> numberOfPlayers [
	^ players size.
]
