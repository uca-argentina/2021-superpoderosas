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
CardHandler >> cancel: aCard [
	influentialCards remove: aCard
		ifAbsent: [ Error signal: self errorMessageAPlayerMustHaveTheCardToBeRemoved ]
]

{ #category : #initialize }
CardHandler >> cancel: aCard of: player [
	(influentialCards at: player) remove: aCard
											ifAbsent: [ Error signal: self errorMessageAPlayerMustHaveTheCardToBeRemoved ]
]

{ #category : #initialize }
CardHandler >> cardsInHandOf: player [
	^ cardsInHand at:player.
]

{ #category : #initialize }
CardHandler >> deliverACardTo: player [
	(cardsInHand at:player) add: (deck pickUp).
]

{ #category : #initialize }
CardHandler >> errorMessageAPlayerMustHaveTheCardInHand [
	^ 'A player must have a card in hand in order to use it'
]

{ #category : #initialize }
CardHandler >> errorMessageAPlayerMustHaveTheCardToBeRemoved [ 
	^'The player must have the influential card needed to be cancelled'.
]

{ #category : #initialize }
CardHandler >> influence: player with: card [
	(influentialCards at: player ) add:card.
]

{ #category : #initialize }
CardHandler >> influenceAllPlayer: card [ 
	influentialCards do: [ :playerInfluentialCards | playerInfluentialCards add: card ]
]

{ #category : #initialize }
CardHandler >> influentialCardsOf: player [
	^ influentialCards at: player
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players [ 
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	influentialCards:= OrderedDictionary newFromKeys: players andValues: (OrderedCollection new: players size withAll: OrderedCollection new).

]

{ #category : #initialize }
CardHandler >> make: player lay: aCard [
	(cardsInHand at:player) remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand ].
]

{ #category : #initialize }
CardHandler >> throw: aCard to: player [ 
	(influentialCards at:player) add: aCard.
]
