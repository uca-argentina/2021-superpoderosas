Class {
	#name : #OneToOneCancellationCardMove,
	#superclass : #OneToOneMove,
	#instVars : [
		'cardToBeCancelled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToOneCancellationCardMove class >> of: aCardToBeCancelled madeBy: aPlayer affecting: anotherPlayer [ 
	^ self new initializeOf: aCardToBeCancelled madeBy: aPlayer affecting: anotherPlayer.
]

{ #category : #accessing }
OneToOneCancellationCardMove >> cardToBeCancelled [
	^ cardToBeCancelled
]

{ #category : #accessing }
OneToOneCancellationCardMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
OneToOneCancellationCardMove >> initializeOf: aCardToBeCancelled madeBy: player affecting: allPlayersAffected [ 
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
	playerAffected := allPlayersAffected.
	
]

{ #category : #accessing }
OneToOneCancellationCardMove >> playerAffected [
	^ playerAffected
]
