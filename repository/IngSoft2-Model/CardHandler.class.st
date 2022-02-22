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

{ #category : #private }
CardHandler >> cancel: card at: fieldInfluentialCards in: aBoardGame [
	| fieldNumber |
	fieldNumber:= fieldsInfluentialCards indexOf: fieldInfluentialCards.
	card annulOutcomeAt: fieldNumber on: aBoardGame handledBy: self.
	fieldInfluentialCards remove: card.
]

{ #category : #'actions - cards' }
CardHandler >> cancel: aCard with: anotherCard on: aBoardGame [
	self validateIfAnyHas: aCard.
	self takeAwayFromInfluentialCards: aCard in: aBoardGame.
	self addToCardsRecord: anotherCard.
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
CardHandler >> influence: target with: card on: influentialCards [
	| targetInfluentialCards |
	targetInfluentialCards := influentialCards at:target.
	targetInfluentialCards add: card.
	influentialCards at: target put: targetInfluentialCards.
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

{ #category : #validations }
CardHandler >> noFieldHas: cardToBeCancelled [

	^ (self selectAssociationsContaining: cardToBeCancelled from: fieldsInfluentialCards) isEmpty.
]

{ #category : #validations }
CardHandler >> noPlayerHas: cardToBeCancelled [

		^ (self selectAssociationsContaining: cardToBeCancelled from: playersInfluentialCards) isEmpty.
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

{ #category : #'actions - cards' }
CardHandler >> takeAwayACardFrom: player [ 
	| playerCardsInHand |
	playerCardsInHand := cardsInHand at:player.
	playerCardsInHand remove: playerCardsInHand last ifAbsent: [].
]

{ #category : #private }
CardHandler >> takeAwayFromFieldsInfluentialCards: cardToBeCancelled in: aBoardGame [
	fieldsInfluentialCards do: [ :fieldInfluentialCards | 
		(fieldInfluentialCards includes: cardToBeCancelled) ifTrue: [ 
			self
				cancel: cardToBeCancelled
				at: fieldInfluentialCards
				in: aBoardGame ] ]
]

{ #category : #'actions - cards' }
CardHandler >> takeAwayFromInfluentialCards: aCard in: aBoardGame [
	self takeAwayFromPlayersInfluentialCards: aCard.
	self takeAwayFromFieldsInfluentialCards: aCard in: aBoardGame.
]

{ #category : #private }
CardHandler >> takeAwayFromPlayersInfluentialCards: cardToBeCancelled [
	playersInfluentialCards
		do:
			[ :playerInfluentialCards | playerInfluentialCards remove: cardToBeCancelled ifAbsent: [  ] ]
]

{ #category : #validations }
CardHandler >> validateIfAnyHas: cardToBeCancelled [
	(self noPlayerHas: cardToBeCancelled) & (self noFieldHas: cardToBeCancelled)
		ifTrue:
			[ Error signal: self errorMessageAPlayerMustCancelACardPermanentlyActive ].
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
