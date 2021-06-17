Class {
	#name : #Deck,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Deck >> initializeContaining: someCards [ 
	^ self subclassResponsibility
]

{ #category : #actions }
Deck >> pickUp [ 
	self subclassResponsibility.
]

{ #category : #actions }
Deck >> pickUp: anAmountOfCards [ 
	| someCards |
	someCards:= OrderedCollection new.
	1 to: anAmountOfCards do:[:i | someCards add: (self pickUp )].
	^someCards.
]
