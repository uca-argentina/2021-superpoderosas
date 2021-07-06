Class {
	#name : #DeterministicDeck,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #inicialization }
DeterministicDeck class >> containing: aCardsSequence [ 
	^self new initializeContaining: aCardsSequence.
]

{ #category : #inirialize }
DeterministicDeck >> initializeContaining: aCardsSequence [  
	sequence := aCardsSequence.
	index := 0.
]

{ #category : #actions }
DeterministicDeck >> pickUp [ 
	index := index + 1. 
	^ sequence at: index.
]

{ #category : #actions }
DeterministicDeck >> pickUp: anAmountOfCards [ 
	| someCards |
	someCards:= OrderedCollection new.
	1 to: anAmountOfCards do:[:i | someCards add: (self pickUp )].
	^someCards.
]
