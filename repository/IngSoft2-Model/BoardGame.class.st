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
		'board',
		'cardsHistory',
		'deck',
		'cardHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
]

{ #category : #'actions - cards' }
BoardGame >> addToCardsRecord: aCard [ 
	cardsHistory add: aCard.
]

{ #category : #'actions - cards' }
BoardGame >> affect: player with: card [ 
	cardHandler influence: player with: card
]

{ #category : #'actions - cards' }
BoardGame >> affectAllPlayers: card [
	cardHandler influenceAllPlayer: card
]

{ #category : #'actions - cards' }
BoardGame >> applyToAllPlayers: aBlock [
	(players) do: [ :player | aBlock value: player ]
]

{ #category : #'actions - cards' }
BoardGame >> cardsInHandOf: aPlayer [
	^ cardHandler cardsInHandOf: aPlayer.
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #'actions - cards' }
BoardGame >> dealACardTo: player [ 
	cardHandler deliverACardTo:player.
]

{ #category : #private }
BoardGame >> endGameIfTheWinnerIs: player [
	| newPosition |
	newPosition := board positionOf: player.
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

{ #category : #'actions - cards' }
BoardGame >> fieldsToMoveAfter: player obtained: sumOfAllDices [
	| result |
	result:= sumOfAllDices.
	(cardHandler influentialCardsOf: player) do: [ :aCard | result :=(result + aCard action) ].
	^ result.
]

{ #category : #actions }
BoardGame >> findPlayerNamed: aName [
	^ players detect: [ :aPlayer | (aPlayer name) = aName ].
]

{ #category : #'actions - cards' }
BoardGame >> influentialCardsOf: aPlayer [
	^ cardHandler influentialCardsOf: aPlayer.
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	deck:= aDeck.
	diceCup := aDiceCup.
	board:= aBoard.
	players := aGroupOfPlayers.
	board placeAtTheBeggining: players.
	playersTurnIdentificator := SequenceSimulator newFrom: (aGroupOfPlayers size).
	isFinished := false.
	spinsNeededToWin := aSpinNumber.
	cardsHistory:= OrderedCollection new.
	cardHandler:= CardHandler managing: aDeck for: players. 
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

{ #category : #'actions - cards' }
BoardGame >> make: player lay: card [
	cardHandler make: player lay: card.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player sumOfAllDices |
	self verifyIfTheGameHasFinished.
	player := self lookForPlayerWhoseTurnItIs.
	sumOfAllDices := diceCup throw.
	sumOfAllDices := self
		fieldsToMoveAfter: player
		obtained: sumOfAllDices.
	board move: player along: sumOfAllDices on: self.
	self endGameIfTheWinnerIs: player.
	^ player
]

{ #category : #actions }
BoardGame >> positionOf: player [
 ^ board positionOf: player.
	
]

{ #category : #accessing }
BoardGame >> ranking [
	^ board playersPosition.
]

{ #category : #'actions - cards' }
BoardGame >> removes: aCard from: aPlayer [ 
	cardHandler cancel: aCard of: aPlayer.
]

{ #category : #'actions - effects' }
BoardGame >> repeatLastEffectAppliedOn: aPlayer [
	board repeatAt: self lastEffectAppliedOn: aPlayer.
	self endGameIfTheWinnerIs: aPlayer.

]

{ #category : #validations }
BoardGame >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Tracker of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
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
	^ board playersPosition first player.
]
