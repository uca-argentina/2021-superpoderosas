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

{ #category : #'actions - cards' }
CardHandler >> cancel: aCard of: player [
	(influentialCards at: player) remove: aCard
											ifAbsent: [ Error signal: self errorMessageAPlayerMustHaveTheCardToBeRemoved ]
]

{ #category : #accessing }
CardHandler >> cardsInHandOf: player [
	^ cardsInHand at:player.
]

{ #category : #'actions - cards' }
CardHandler >> deliverACardTo: player [
	(cardsInHand at:player) add: (deck pickUp).
]

{ #category : #'error messages' }
CardHandler >> errorMessageAPlayerMustHaveTheCardInHand [
	^ 'A player must have a card in hand in order to use it'
]

{ #category : #'error messages' }
CardHandler >> errorMessageAPlayerMustHaveTheCardToBeRemoved [ 
	^'The player must have the influential card needed to be cancelled'.
]

{ #category : #'actions - cards' }
CardHandler >> influence: player with: card [
	| playerInfluentialCards |
	playerInfluentialCards := influentialCards at:player.
	playerInfluentialCards add: card.
	influentialCards at: player put: playerInfluentialCards.
	"(influentialCards at: player) add:Card"
]

{ #category : #'actions - cards' }
CardHandler >> influenceAllPlayer: card [ 
	influentialCards do: [ :playerInfluentialCards | playerInfluentialCards add: card ]
]

{ #category : #accessing }
CardHandler >> influentialCardsOf: player [
	^ influentialCards at: player
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players [ 
	| values |
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	values:= players collect: [ :player | OrderedCollection new ].
	influentialCards:= OrderedDictionary newFromKeys: players andValues: values.

]

{ #category : #'actions - cards' }
CardHandler >> make: player lay: aCard [
	(cardsInHand at:player) remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand ].
]
