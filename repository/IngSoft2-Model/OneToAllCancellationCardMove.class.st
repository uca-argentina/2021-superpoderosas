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

{ #category : #accessing }
OneToAllCancellationCardMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
OneToAllCancellationCardMove >> of: aCardToBeCancelled madeBy: player [
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
]
