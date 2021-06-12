Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'diceCup',
		'spinsNeededToWin',
		'playersPosition',
		'numberOfFields',
		'board',
		'effectsHistory',
		'cardsHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber [
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
]

{ #category : #'actions - cards' }
BoardGame >> a: card of: cardToBeCancel wantsToBeThrowTo: player by: currentPlayer [ 
	(self verifyIf: card canBePlayedBy: currentPlayer).
	currentPlayer lays: card.
	card actAt: self on: player with: cardToBeCancel .
	(card class = DoOver) ifFalse:[cardsHistory add: card].
]

{ #category : #'actions - cards' }
BoardGame >> a: card of: cardToBeCancel wantsToBeThrownBy: currentPlayer [  
	(self verifyIf: card canBePlayedBy: currentPlayer).
	currentPlayer lays: card.
	card actAt: self with: cardToBeCancel .
	(card class = DoOver) ifFalse:[cardsHistory add: card].
]

{ #category : #'actions - cards' }
BoardGame >> a: card wantsToBeThrownBy: currentPlayer [ 
	(self verifyIf: card canBePlayedBy: currentPlayer).
	currentPlayer lays: card.
	card actAt: self.
	(card class = DoOver) ifFalse:[cardsHistory add: card].
]

{ #category : #'actions - cards' }
BoardGame >> a: card wantsToBeThrownTo: player by: currentPlayer [ 
	(self verifyIf: card canBePlayedBy: currentPlayer).
	currentPlayer lays: card.
	card actAt: self on: player.
	(card class = DoOver) ifFalse:[cardsHistory add: card].
]

{ #category : #private }
BoardGame >> addOrSubstractOneIfThePlayerHasChangedRound: totalFields [
	^ (totalFields-1) // numberOfFields.

]

{ #category : #private }
BoardGame >> apply: aCard on: aPlayer [
		aPlayer isInfluencedBy: aCard.
]

{ #category : #actions }
BoardGame >> applyInfluentialCardsOn: sumOfAllDices of: player [
	| result |
	result:= sumOfAllDices.
	(player influentialCards) do: [ :aCard | result :=(result + aCard action) ].
	^ result.
]

{ #category : #actions }
BoardGame >> applyLastCardThrownTo: aPlayer [
	(cardsHistory isEmpty) 
		ifFalse:[ 
			(cardsHistory last) actAt: self on: aPlayer.].
]

{ #category : #actions }
BoardGame >> applyLastEffectTo: aPlayer [
	effectsHistory last applyTheEffectOn: (self detectPositionOf: aPlayer) of: self.
	self endGameIfTheWinnerIs: aPlayer.
	self orderPlayersPosition.
]

{ #category : #actions }
BoardGame >> applyLastEffectToAllPlayers [
	players do: [:player | effectsHistory last applyTheEffectOn: (self detectPositionOf: player) of: self. self endGameIfTheWinnerIs: player].
	self orderPlayersPosition.
]

{ #category : #private }
BoardGame >> applyToAllPlayers: aCard [
	players do: [:player | player isInfluencedBy: aCard].
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #actions }
BoardGame >> deal: aCard toPlayerOf: aPosition [ 
	aPosition player pickUp: aCard.
]

{ #category : #actions }
BoardGame >> detectPositionOf: player [
 ^playersPosition detect: [ :aPosition | aPosition player= player ].
	
]

{ #category : #private }
BoardGame >> endGameIfTheWinnerIs: player [
	| newPosition |
	newPosition := self detectPositionOf: player.
	newPosition round > spinsNeededToWin
		ifTrue: [ self changeCurrentStateToFinished ]
]

{ #category : #'error messages' }
BoardGame >> errorMessageCardCanNotBePlayedOutsidePlayersTurn [
 ^ 'All permanent cards can only be played when it is the turn of the player'.
]

{ #category : #'error messages' }
BoardGame >> errorMessageDoesNotHaveAWinnerYet [
	^ 'The board game has not finished yet, so it does not have a winner.'.
]

{ #category : #'error messages' }
BoardGame >> errorMessageMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame >> errorMessageTheGameHasFinished [
	^ 'The board game has already finished, contestants can not play anymore.'.
]

{ #category : #private }
BoardGame >> findNewPositionWhen: aPlayer hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber :=  oldPosition round + (self addOrSubstractOneIfThePlayerHasChangedRound: totalFields).
	newPosition := Position of: aPlayer standingOn: newFieldNumber after: newRoundNumber.
	newPosition := self validate: newPosition.
	^ newPosition
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	diceCup := aDiceCup.
	board:= aBoard.
	players := aGroupOfPlayers.
	playersTurnIdentificator := SequenceSimulator newFrom: (aGroupOfPlayers size).
	isFinished := false.
	spinsNeededToWin := aSpinNumber.
	numberOfFields := aBoard numberOfFields.
	playersPosition:= OrderedCollection newFrom: (self placePlayersAtTheInitialPosition).
	effectsHistory:= OrderedCollection new.
	cardsHistory:= OrderedCollection new.
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #private }
BoardGame >> lookForPlayerWhoseTurnItIs [
	^ players at: (playersTurnIdentificator findNextIndex).
]

{ #category : #private }
BoardGame >> lookUpResultingFieldNumberBasingOn: totalFields [
	^ totalFields = numberOfFields
		ifTrue: [ numberOfFields ]
		ifFalse: [ totalFields > 0
				ifTrue: [ totalFields % numberOfFields ]
				ifFalse: [numberOfFields + totalFields] ]
]

{ #category : #private }
BoardGame >> move: player along: result [
	| oldPosition |
	oldPosition := self detectPositionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition.
]

{ #category : #actions }
BoardGame >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := board searchFieldFor: newPosition.
	effect:=field applyTheEffectOn: newPosition of: self.
	effectsHistory add:effect.
	
]

{ #category : #actions }
BoardGame >> move: aPlayer over: aNumberOfFields from: oldPosition [
	| newPosition |
	newPosition := self findNewPositionWhen: aPlayer hasMoved: aNumberOfFields from: oldPosition.
	self replace: oldPosition with: newPosition.
	^ newPosition
]

{ #category : #actions }
BoardGame >> move: aNumberOfFields thePlayerOf: oldPosition [
	self move: (oldPosition player) over: aNumberOfFields from: oldPosition.
]

{ #category : #actions }
BoardGame >> moveAllPlayers: aNumberOfFields exceptThePlayerOf: aPosition [
	playersPosition  := playersPosition reject: [ :position | position=aPosition ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	playersPosition add: aPosition .
]

{ #category : #accessing }
BoardGame >> moveAllPlayersTo: aField [
	playersPosition := playersPosition collect: [ :position | Position of: (position player) standingOn: 1 after: (position round) ]
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player sumOfAllDices |
	self verifyIfTheGameHasFinished.
	player := self lookForPlayerWhoseTurnItIs.
	sumOfAllDices := diceCup throw.
	sumOfAllDices := self applyInfluentialCardsOn: sumOfAllDices of: player.
	self move: player along: sumOfAllDices.
	self endGameIfTheWinnerIs: player.
	self orderPlayersPosition.
	^ player.

]

{ #category : #actions }
BoardGame >> orderPlayersPosition [
	playersPosition
		sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
]

{ #category : #initialize }
BoardGame >> placePlayersAtTheInitialPosition [
	^ players
		collect: [ :aPlayer | Position of: aPlayer standingOn: 1 after: 1 ]
]

{ #category : #accessing }
BoardGame >> ranking [
	^ playersPosition.
]

{ #category : #actions }
BoardGame >> removes: aCard from: aPlayer [ 
	aPlayer cancel: aCard.
]

{ #category : #actions }
BoardGame >> removesEveryPlayers: card [ 
	players do: [:player| player cancel: card].
]

{ #category : #actions }
BoardGame >> repeatlastEffectApplied [
	effectsHistory isEmpty
		ifFalse:
			[ self applyLastEffectToAllPlayers ]
]

{ #category : #actions }
BoardGame >> repeatlastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyLastEffectTo: aPlayer ]
]

{ #category : #private }
BoardGame >> replace: oldPosition with: newPosition [
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
]

{ #category : #actions }
BoardGame >> theLastCardThrownCanBePlayedInAnyTurn [
	^ (cardsHistory isEmpty) 
	ifTrue: [ true. ]
	ifFalse: [(cardsHistory last) canBePlayedInAnyTurn].
]

{ #category : #private }
BoardGame >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Position of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
]

{ #category : #validations }
BoardGame >> verifyIf: card canBePlayedBy: currentPlayer [
	(card canBePlayedInAnyTurnAt:self) ifFalse:[ self verifyIfItIsTheTurnOf: currentPlayer ]
]

{ #category : #validations }
BoardGame >> verifyIfItIsNotEmpty: aGroupOfPlayers [ 
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastAPlayer ] .
]

{ #category : #validations }
BoardGame >> verifyIfItIsTheTurnOf: currentPlayer [
	(currentPlayer = (players at: (playersTurnIdentificator actualIndex))) ifFalse:[Error signal: self errorMessageCardCanNotBePlayedOutsidePlayersTurn]
]

{ #category : #validations }
BoardGame >> verifyIfTheGameHasFinished [
	(isFinished) 
		ifTrue: [ Error signal: self errorMessageTheGameHasFinished] .
]

{ #category : #validations }
BoardGame >> verifyIfTheGameIsInProcess [
	isFinished
		ifFalse: [ Error signal: self errorMessageDoesNotHaveAWinnerYet ]
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameIsInProcess.	
	^ playersPosition first player.
]
