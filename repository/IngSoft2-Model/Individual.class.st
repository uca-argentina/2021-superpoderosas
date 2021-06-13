Class {
	#name : #Individual,
	#superclass : #Object,
	#instVars : [
		'card',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Individual class >> throwing: aCard to: aPlayer [ 
	^self new initializeThrowing: aCard to: aPlayer.
]

{ #category : #initialize }
Individual >> initializeThrowing: aCard to: aPlayer [ 
	card:= aCard.
	player:= aPlayer.
]
