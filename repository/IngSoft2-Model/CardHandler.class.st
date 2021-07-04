Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardsInHand',
		'influentialCards',
		'cardsHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #inicialization }
CardHandler class >> managing: aDeck for: players [ 
	^ self new initializeManaging: aDeck for: players
]

{ #category : #'error messages' }
CardHandler >> addToCardsRecord: aCard [ 
	cardsHistory add: aCard.
]

{ #category : #'actions - cards' }
CardHandler >> affect: aTarget using: aCard by: aPlayer on: aBoardGame [
	self make: aPlayer lay: aCard.
	aCard thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self.
]

{ #category : #'actions - cards' }
CardHandler >> cancel: cardToBeCancelled with: aCard [
	(influentialCards) valuesDo: [ :playerInfluentialCards | ( playerInfluentialCards remove: cardToBeCancelled ifAbsent:[])].
	self addToCardsRecord: aCard.
]

{ #category : #accessing }
CardHandler >> cardsInHandOf: player [
	^ cardsInHand at: player.
]

{ #category : #'actions - cards' }
CardHandler >> deliverACardTo: player [
	(cardsInHand at:player) add: (deck pickUp).
]

{ #category : #'error messages' }
CardHandler >> errorMessageAPlayerMustHaveTheCardInHand [
	^ 'A player must have a card in hand in order to use it'
]

{ #category : #'actions - cards' }
CardHandler >> influence: player with: card [
	| playerInfluentialCards |
	playerInfluentialCards := influentialCards at:player.
	playerInfluentialCards add: card.
	influentialCards at: player put: playerInfluentialCards.
	self addToCardsRecord: card.
]

{ #category : #'actions - cards' }
CardHandler >> influenceAllPlayers: card [ 
	influentialCards do: [ :playerInfluentialCards | playerInfluentialCards add: card ].
	self addToCardsRecord: card 
]

{ #category : #accessing }
CardHandler >> influentialCardsOf: player [
	^ influentialCards at: player
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players [ 
	| playersInfluentialCards |
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	playersInfluentialCards:= players collect: [ :player | OrderedCollection new ].
	influentialCards:= OrderedDictionary newFromKeys: players andValues: playersInfluentialCards.
	cardsHistory:= OrderedCollection new.

]

{ #category : #'actions - cards' }
CardHandler >> make: player lay: aCard [
	(cardsInHand at:player) remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand].
]

{ #category : #'actions - cards' }
CardHandler >> repeatLastCardThrownBy: aPlayer affecting: aTarget on: aBoardGame [
	(cardsHistory isEmpty) 
	ifFalse: [ (cardsHistory last) thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self].
]

{ #category : #'actions - cards' }
CardHandler >> with: aCard repeatLastEffectAppliedOn: aBoardGame targeting: aPlayer [
	aBoardGame repeatLastEffectAppliedOn: aPlayer.
	self addToCardsRecord: aCard.
]
