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
	^ self new initializeOf: aCardToBeCancelled  madeBy: player.
]

{ #category : #actions }
OneToAllCancellationCardMove >> cardToBeCancelled [
	^ cardToBeCancelled
]

{ #category : #accessing }
OneToAllCancellationCardMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
OneToAllCancellationCardMove >> initializeOf: aCardToBeCancelled madeBy: player [
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
]
