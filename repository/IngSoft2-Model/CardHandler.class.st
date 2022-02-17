Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardsInHand',
		'cardsHistory',
		'playersInfluentialCards',
		'fieldsInfluentialCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #inicialization }
CardHandler class >> managing: aDeck for: players inABoardWith: aNumberOfFields [
	^ self new initializeManaging: aDeck for: players inABoardWith: aNumberOfFields.
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
	self validateIfAnyHas: cardToBeCancelled.
	self removeFromPlayersInfluentialCards: cardToBeCancelled.
	self removeFromFieldsInfluentialCards: cardToBeCancelled on: aBoardGame.
	self addToCardsRecord: aCard
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
CardHandler >> errorMessageAPlayerMustCancelACardPermanentlyActive [
 ^'You cannot cancel a card that is not permanently active.'
]

{ #category : #'error messages' }
CardHandler >> errorMessageAPlayerMustHaveTheCardInHand [
	^ 'A player must have a card in hand in order to use it'
]

{ #category : #'actions - cards' }
CardHandler >> influence: player with: card [
	self influence: player with: card on: playersInfluentialCards .
]

{ #category : #'actions - cards' }
CardHandler >> influence: target with: card on: targetsInfluentialCards [
	| targetInfluentialCards |
	targetInfluentialCards := targetsInfluentialCards at:target.
	targetInfluentialCards add: card.
	targetsInfluentialCards at: target put: targetInfluentialCards.
	self addToCardsRecord: card.
]

{ #category : #'actions - cards' }
CardHandler >> influenceAllPlayers: card [ 
	playersInfluentialCards do: [ :playerInfluentialCards | playerInfluentialCards add: card ].
	self addToCardsRecord: card 
]

{ #category : #accessing }
CardHandler >> influentialCardsOf: player [
	^ playersInfluentialCards at: player
]

{ #category : #initialize }
CardHandler >> initializeManaging: aDeck for: players inABoardWith: aNumberOfFields [ 
	| influentialCardsOfPlayers influentialCardsOfFields |
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	influentialCardsOfPlayers:= players collect: [ :player | OrderedCollection new ].
	playersInfluentialCards:= OrderedDictionary newFromKeys: players andValues: influentialCardsOfPlayers.
	cardsHistory:= OrderedCollection new.
	influentialCardsOfFields:= (1 to: aNumberOfFields) collect: [ :player | OrderedCollection new ].
	fieldsInfluentialCards:= OrderedCollection withAll: influentialCardsOfFields.

]

{ #category : #'actions - cards' }
CardHandler >> make: player lay: aCard [
	(cardsInHand at:player) remove: aCard ifAbsent: [Error signal: self errorMessageAPlayerMustHaveTheCardInHand].
]

{ #category : #'actions - cards' }
CardHandler >> removeACardFrom: player [ 
	| playerCardsInHand |
	playerCardsInHand := cardsInHand at:player.
	playerCardsInHand remove: playerCardsInHand last ifAbsent: [].
]

{ #category : #private }
CardHandler >> removeFromFieldsInfluentialCards: cardToBeCancelled on: aBoardGame [

	| fieldInfluentialCards |
	1 to: (fieldsInfluentialCards size) do: [ :aFieldNumber |fieldInfluentialCards:= fieldsInfluentialCards at: aFieldNumber .  (fieldInfluentialCards includes: cardToBeCancelled) ifTrue: [ 
			cardToBeCancelled annulOutcomeAt: aFieldNumber on: aBoardGame handledBy: self.
			fieldInfluentialCards remove: cardToBeCancelled ]] .
]

{ #category : #private }
CardHandler >> removeFromPlayersInfluentialCards: cardToBeCancelled [
	playersInfluentialCards
		do:
			[ :playerInfluentialCards | playerInfluentialCards remove: cardToBeCancelled ifAbsent: [  ] ]
]

{ #category : #'actions - cards' }
CardHandler >> repeatLastCardThrownBy: aPlayer affecting: aTarget on: aBoardGame [
	cardsHistory ifNotEmpty: [ (cardsHistory last) thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self].
]

{ #category : #private }
CardHandler >> selectAssociationsContaining: cardToBeCancelled from: influentialCards [
	^ influentialCards
		select: [ :cards | 
			cards
				anySatisfy: [ :card | card = cardToBeCancelled ] ]
]

{ #category : #validations }
CardHandler >> validateIfAnyHas: cardToBeCancelled [
	(self selectAssociationsContaining: cardToBeCancelled from: playersInfluentialCards) isEmpty & (self selectAssociationsContaining: cardToBeCancelled from: fieldsInfluentialCards) isEmpty
		ifTrue:
			[ Error signal: self errorMessageAPlayerMustCancelACardPermanentlyActive ]
]

{ #category : #'actions - cards' }
CardHandler >> with: aCard repeatLastEffectAppliedOn: aBoardGame targeting: aPlayer [
	aBoardGame repeatLastEffectAppliedOn: aPlayer.
	self addToCardsRecord: aCard.
]

{ #category : #'actions - cards' }
CardHandler >> with: aCard reverseTheEffectOf: aField on: aBoardGame [
	aBoardGame reverseTheEffectOf: aField.
	self influence: aField with: aCard on: fieldsInfluentialCards.
]
