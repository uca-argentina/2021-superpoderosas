Class {
	#name : #RandomDeck,
	#superclass : #Deck,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomDeck class >> containing: someCards [ 
	^self new initializeContaining: someCards.
]

{ #category : #initialize }
RandomDeck >> initializeContaining: someCards [ 
	cards:= someCards.
]

{ #category : #actions }
RandomDeck >> pickUp [
	^cards atRandom: (Random new).
]
