Class {
	#name : #DeterministicDeck,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #inicialization }
DeterministicDeck class >> containing: aCardsSequence [ 
	^self new initializeContaining: aCardsSequence.
]

{ #category : #inirialize }
DeterministicDeck >> initializeContaining: aCardsSequence [  
	sequence:= Sequence newFrom: aCardsSequence.
]

{ #category : #actions }
DeterministicDeck >> pickUp [ 
	"index := index + 1. 
	^ sequence at: index."
	^sequence nextElement.
]

{ #category : #actions }
DeterministicDeck >> pickUp: anAmountOfCards [ 
	| someCards |
	someCards:= OrderedCollection new.
	1 to: anAmountOfCards do:[:i | someCards add: (self pickUp )].
	^someCards.
]
