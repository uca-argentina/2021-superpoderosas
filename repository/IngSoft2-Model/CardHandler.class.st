Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardsInHand',
		'influentialCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #inicialization }
CardHandler class >> managing: aDeck for: players [ 
	^ self new initializeManaging: aDeck for: players
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players [ 
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	influentialCards:= OrderedDictionary new.

]
