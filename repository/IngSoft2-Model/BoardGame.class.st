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
		'cardsHistory',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
]

{ #category : #private }
BoardGame >> addOrSubstractOneIfThePlayerHasChangedRound: totalFields [
	^ (totalFields-1) // numberOfFields.

]

{ #category : #'actions - cards' }
BoardGame >> addToCardsRecord: aCard [ 
	cardsHistory add: aCard.
]

{ #category : #'actions - cards' }
BoardGame >> applyInfluentialCardsOn: sumOfAllDices of: player [
	| result |
	result:= sumOfAllDices.
	(player influentialCards) do: [ :aCard | result :=(result + aCard action) ].
	^ result.
]

{ #category : #'actions - effects' }
BoardGame >> applyLastEffectTo: aPlayer [
	effectsHistory last applyTheEffectOn: (self detectPositionOf: aPlayer) of: self.
	self endGameIfTheWinnerIs: aPlayer.
	self orderPlayersPosition.
]

{ #category : #'actions - cards' }
BoardGame >> applyToAllPlayers: aBlock [
	(players) do: [ :player | aBlock value: player ]
]

{ #category : #'actions - cards' }
BoardGame >> cardsInHandOf: aPlayer [
	^ aPlayer cardsInHand.
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #'actions - cards' }
BoardGame >> dealACardToPlayerOf: aPosition [ 
	| card |
	card:= deck pickUp.
	(aPosition player) pickUp: card.
]

{ #category : #actions }
BoardGame >> detectPositionOf: player [
 ^playersPosition detect: [ :aPosition | aPosition player = player ].
	
]

{ #category : #actions }
BoardGame >> do: anOverloadCardMove [ 
	self shouldBeImplemented.
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
BoardGame >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber :=  oldPosition round + (self addOrSubstractOneIfThePlayerHasChangedRound: totalFields).
	newPosition := Position of: player standingOn: newFieldNumber after: newRoundNumber.
	newPosition := self validate: newPosition.
	^ newPosition
]

{ #category : #actions }
BoardGame >> findPlayerNamed: aName [
	^ players detect: [ :aPlayer | (aPlayer name) = aName ].
]

{ #category : #'actions - cards' }
BoardGame >> influentialCardsOf: aPlayer [
	^ aPlayer influentialCards.
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	deck:= aDeck.
	diceCup := aDiceCup.
	board:= aBoard.
	players := OrderedCollection newFrom:(aGroupOfPlayers collect:[:playerName | Player named: playerName with: (aDeck pickUp: 2)]).
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

{ #category : #'actions - cards' }
BoardGame >> letTheLastCardPlayedDo: aMove [
	(cardsHistory isEmpty) 
	ifFalse: [(cardsHistory last) apply: aMove at: self].
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
	effect := field applyTheEffectOn: newPosition of: self.
	effectsHistory add: effect.
	
]

{ #category : #actions }
BoardGame >> move: player over: aNumberOfFields from: oldPosition [
	| newPosition |
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
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

{ #category : #'actions - remove' }
BoardGame >> removes: aCard from: aPlayer [ 
	aPlayer cancel: aCard.
]

{ #category : #'actions - effects' }
BoardGame >> repeatlastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyLastEffectTo: aPlayer ].
]

{ #category : #private }
BoardGame >> replace: oldPosition with: newPosition [
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
]

{ #category : #private }
BoardGame >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Position of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
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
