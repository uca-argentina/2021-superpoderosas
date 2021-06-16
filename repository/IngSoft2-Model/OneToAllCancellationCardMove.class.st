Class {
	#name : #OneToAllCancellationCardMove,
	#superclass : #OneToAllMove,
	#instVars : [
		'cardToBeCancelled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToAllCancellationCardMove class >> of: aCardToBeCancelled madeBy: player [ 
	^self new of: aCardToBeCancelled madeBy: player.
]

{ #category : #actions }
OneToAllCancellationCardMove >> cardToBeCancelled [
	^ cardToBeCancelled
]

{ #category : #initialization }
OneToAllCancellationCardMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialization }
OneToAllCancellationCardMove >> of: aCardToBeCancelled madeBy: player [
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
]
