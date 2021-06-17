Class {
	#name : #OneToOneCancellationCardMove,
	#superclass : #OneToOneMove,
	#instVars : [
		'cardToBeCancelled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToOneCancellationCardMove class >> of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected [ 
	^self new of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected.
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
OneToOneCancellationCardMove >> of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected [ 
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
	playerAffected := allPlayersAffected.
	
]

{ #category : #accessing }
OneToOneCancellationCardMove >> playerAffected [
	^ playerAffected
]
