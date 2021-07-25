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
CardHandler class >> managing: aDeck for: players and: fields [
	^ self new initializeManaging: aDeck for: players and: fields
]

{ #category : #private }
CardHandler >> addToCardsRecord: aCard [ 
	cardsHistory add: aCard.
]

{ #category : #'actions - cards' }
CardHandler >> affect: aTarget using: aCard by: aPlayer on: aBoardGame [
	self make: aPlayer lay: aCard.
	aCard thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self.
]

{ #category : #'actions - cards' }
CardHandler >> cancel: cardToBeCancelled with: aCard on: aBoardGame [
	| target |
	self validateIfAnyPlayerHas: cardToBeCancelled.
	target:= self findTargetContaining: cardToBeCancelled.
	self removeFromInfluentialCards: cardToBeCancelled.
	self addToCardsRecord: aCard.
	cardToBeCancelled notifyCancellationRegarding: target on: aBoardGame.
]

{ #category : #accessing }
CardHandler >> cardsInHandOf: player [
	^ cardsInHand at: player.
]

{ #category : #private }
CardHandler >> defineInfluentialCardsOf: players and: fields [
	| targetsInfluentialCards targets |
	targets := self defineTargetsWith: players and: fields.
	targetsInfluentialCards := targets collect: [ :player | OrderedCollection new ].
	influentialCards := OrderedDictionary newFromKeys: targets andValues: targetsInfluentialCards
]

{ #category : #private }
CardHandler >> defineTargetsWith: players and: fields [
	| targets fieldNumeration |
	fieldNumeration := OrderedCollection new.
	1 to: fields size do: [ :fieldNumber | fieldNumeration add: fieldNumber ].
	targets := players , fieldNumeration.
	^ targets
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
CardHandler >> errorMessageThePlayerDoesNotHaveTheCardToBeCancel [
 ^'The player does not have the card to be cancelled.'
]

{ #category : #accessing }
CardHandler >> findTargetContaining: card [
	^ (self selectAssociationsContaining: card) keys first.
]

{ #category : #'actions - cards' }
CardHandler >> influence: target with: card [
	| targetInfluentialCards |
	targetInfluentialCards := influentialCards at: target .
	targetInfluentialCards add: card.
	influentialCards at: target put: targetInfluentialCards.
	self addToCardsRecord: card.
]

{ #category : #'actions - cards' }
CardHandler >> influenceAllPlayers: card [ 
	influentialCards do: [ :targetInfluentialCards | targetInfluentialCards add: card ].
	self addToCardsRecord: card 
]

{ #category : #accessing }
CardHandler >> influentialCardsOf: target [
	^ influentialCards at: target.
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players and: fields [
	deck := aDeck.
	cardsInHand := OrderedDictionary newFromKeys: players andValues: (players collect: [ :player | aDeck pickUp: 2 ]).
	self defineInfluentialCardsOf: players and: fields.
	cardsHistory := OrderedCollection new
]

{ #category : #'actions - cards' }
CardHandler >> make: player lay: aCard [
	(cardsInHand at:player) remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand].
]

{ #category : #private }
CardHandler >> removeFromInfluentialCards: cardToBeCancelled [
	influentialCards
		do:
			[ :playerInfluentialCards | playerInfluentialCards remove: cardToBeCancelled ifAbsent: [  ] ]
]

{ #category : #'actions - cards' }
CardHandler >> repeatLastCardThrownBy: aPlayer affecting: aTarget on: aBoardGame [
	cardsHistory  ifNotEmpty: [ (cardsHistory last) thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self].
]

{ #category : #private }
CardHandler >> selectAssociationsContaining: cardToBeCancelled [
	^ influentialCards
		select: [ :playerInfluentialCards | 
			playerInfluentialCards
				anySatisfy: [ :card | card = cardToBeCancelled ] ]
]

{ #category : #validations }
CardHandler >> validateIfAnyPlayerHas: cardToBeCancelled [
	(self selectAssociationsContaining: cardToBeCancelled) isEmpty
		ifTrue:
			[ Error signal: self errorMessageThePlayerDoesNotHaveTheCardToBeCancel ]
]

{ #category : #'actions - cards' }
CardHandler >> with: aCard repeatLastEffectAppliedOn: aBoardGame targeting: aPlayer [
	aBoardGame repeatLastEffectAppliedOn: aPlayer.
	self addToCardsRecord: aCard.
]
