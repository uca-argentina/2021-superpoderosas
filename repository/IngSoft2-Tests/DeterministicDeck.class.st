Class {
	#name : #DeterministicDeck,
	#superclass : #Deck,
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
	index := SequenceSimulator newFrom: (aCardsSequence size ).
]

{ #category : #actions }
DeterministicDeck >> pickUp [ 
	^ sequence at: (index findNextIndex).
]
