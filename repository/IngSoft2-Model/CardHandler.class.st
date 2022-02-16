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

{ #category : #private }
CardHandler >> addToFieldsInfluentialCards: aCard at: aField [
	fieldsInfluentialCards at: aField put: aCard.

]

{ #category : #'actions - cards' }
CardHandler >> affect: aTarget using: aCard by: aPlayer on: aBoardGame [
	self make: aPlayer lay: aCard.
	aCard thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: self.
]

{ #category : #'actions - cards' }
CardHandler >> cancel: cardToBeCancelled with: aCard [
	self validateIfAnyPlayerHas: cardToBeCancelled.
	self removeFromPlayersInfluentialCards: cardToBeCancelled.
	self removeFromFieldsInfluentialCards: cardToBeCancelled.
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
	| playerInfluentialCards |
	playerInfluentialCards := playersInfluentialCards at:player.
	playerInfluentialCards add: card.
	playersInfluentialCards at: player put: playerInfluentialCards.
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
	| influentialCardsOfPlayers |
	deck:= aDeck.
	cardsInHand:= OrderedDictionary newFromKeys: players andValues:(players collect:[:player |(aDeck pickUp:2)]).
	influentialCardsOfPlayers:= players collect: [ :player | OrderedCollection new ].
	playersInfluentialCards:= OrderedDictionary newFromKeys: players andValues: influentialCardsOfPlayers.
	cardsHistory:= OrderedCollection new.
	fieldsInfluentialCards:= Array new: aNumberOfFields withAll: [].

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
CardHandler >> removeFromFieldsInfluentialCards: cardToBeCancelled [
	fieldsInfluentialCards 
		do:
			[ :fieldInfluentialCards | fieldInfluentialCards remove: cardToBeCancelled ifAbsent: [  ] ]
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
CardHandler >> selectAssociationsContaining: cardToBeCancelled [
	^ playersInfluentialCards
		select: [ :playerInfluentialCards | 
			playerInfluentialCards
				anySatisfy: [ :card | card = cardToBeCancelled ] ]
]

{ #category : #validations }
CardHandler >> validateIfAnyPlayerHas: cardToBeCancelled [
	(self selectAssociationsContaining: cardToBeCancelled) isEmpty
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
	self addToFieldsInfluentialCards: aCard at: aField.
	aBoardGame reverseTheEffectOf: aField.
]
