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

{ #category : #accessing }
Player >> cards [
	^ cardsInHand.
]

{ #category : #accessing }
Player >> influentialCards [
	^ influentialCards
]

{ #category : #initialize }
Player >> initializeNamed: aName with: someCards [ 
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
	cardsInHand remove: aCard.
]

{ #category : #accesing }
Player >> name [
	^ name
]

{ #category : #actions }
Player >> pickUp: aCard [
	cardsInHand add: aCard.
]
