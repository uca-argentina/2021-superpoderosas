Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'cardsInHand',
		'influentialCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> named: aName with: someCards [
	^ self new initializeNamed: aName with: someCards.
	
]

{ #category : #accessing }
Player >> = anotherPlayer [
	^ (self name = anotherPlayer name).
]

{ #category : #actions }
Player >> cancel: aCard [
	influentialCards remove: aCard
		ifAbsent: [ Error signal: self errorMessageAPlayerMustHaveTheCardToBeRemoved ]
]

{ #category : #accessing }
Player >> cardsInHand [
	^ cardsInHand.
]

{ #category : #'error messages' }
Player >> errorMessageAPlayerMustHaveTheCardInHand [
	^ 'A player must have a card in hand in order to use it'
]

{ #category : #'error messages' }
Player >> errorMessageAPlayerMustHaveTheCardToBeRemoved [ 
	^'The player must have the influential card needed to be cancelled'.
]

{ #category : #accessing }
Player >> influentialCards [
	^ influentialCards
]

{ #category : #initialize }
Player >> initializeNamed: aName with: someCards [ .
	name:= aName.
	cardsInHand:=someCards.
	influentialCards:= OrderedCollection new.
	
	
]

{ #category : #actions }
Player >> isInfluencedBy: aCard [ 
	influentialCards add: aCard.
]

{ #category : #actions }
Player >> lays: aCard [
	cardsInHand remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand ].
]

{ #category : #accessing }
Player >> name [
	^ name
]

{ #category : #actions }
Player >> pickUp: aCard [
	cardsInHand add: aCard.
]
