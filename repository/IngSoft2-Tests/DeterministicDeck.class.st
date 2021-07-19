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

{ #category : #'error messages' }
DeterministicDeck >> errorMessageTheDeckIsNotInfinite [
	^ 'The deck is not infinite, there are no more cards to be handled'
]

{ #category : #inirialize }
DeterministicDeck >> initializeContaining: aCardsSequence [  
	sequence := aCardsSequence.
	index := 0.
]

{ #category : #actions }
DeterministicDeck >> pickUp [
	index := index + 1.
	index > sequence size
		ifTrue:
			[ Error signal: self errorMessageTheDeckIsNotInfinite ]
		ifFalse: [ ^ sequence at: index ]
]

{ #category : #actions }
DeterministicDeck >> pickUp: anAmountOfCards [ 
	| someCards |
	someCards:= OrderedCollection new.
	1 to: anAmountOfCards do:[:i | someCards add: (self pickUp )].
	^someCards.
]
