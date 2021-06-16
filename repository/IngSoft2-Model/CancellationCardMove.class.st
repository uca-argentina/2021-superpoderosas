Class {
	#name : #CancellationCardMove,
	#superclass : #Object,
	#instVars : [
		'cardToBeCancelled',
		'currentPlayer',
		'playersAffected'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
CancellationCardMove class >> of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected [ 
	^self new of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected.
]

{ #category : #accessing }
CancellationCardMove >> cardToBeCancelled [
	^ cardToBeCancelled
]

{ #category : #accessing }
CancellationCardMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
CancellationCardMove >> of: aCardToBeCancelled madeBy: player affecting: allPlayersAffected [ 
	cardToBeCancelled := aCardToBeCancelled.
	currentPlayer := player.
	playersAffected := allPlayersAffected.
	
]

{ #category : #accesing }
CancellationCardMove >> playersAffected [
	^ playersAffected
]
