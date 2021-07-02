Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Deck class >> containing: someCards [ 
	^self new initializeContaining: someCards.
]

{ #category : #initialize }
Deck >> initializeContaining: someCards [ 
	cards:= someCards.
	random := Random new.
]

{ #category : #actions }
Deck >> pickUp [
	^cards atRandom: (random).
]

{ #category : #actions }
Deck >> pickUp: anAmountOfCards [ 
	| someCards |
	someCards:= OrderedCollection new.
	1 to: anAmountOfCards do:[:i | someCards add: (self pickUp )].
	^someCards.
]
