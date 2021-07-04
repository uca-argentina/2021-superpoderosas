Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'diceCup',
		'spinsNeededToWin',
		'board',
		'cardHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame class >> errorMessageSpinNumberMustBeGreaterThanCero [
	^ 'The board game must have at leaste one lap'
]

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
		self verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers .
		self verifySpinNumberIsGreaterThanCero: aSpinNumber.
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber.
]

{ #category : #validations }
BoardGame class >> verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers [ 
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastAPlayer ] .
]

{ #category : #validations }
BoardGame class >> verifySpinNumberIsGreaterThanCero: aSpinNumber [.
	(aSpinNumber <1 ) 
		ifTrue: [ Error signal: self errorMessageSpinNumberMustBeGreaterThanCero ] .
]

{ #category : #'actions - cards' }
BoardGame >> affect: aTarget using: aCard by: aPlayer [
	cardHandler
		affect: aTarget
		using: aCard
		by: aPlayer
		on: self
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

{ #category : #'actions - cards' }
BoardGame >> influentialCardsOf: aPlayer [
	^ cardHandler influentialCardsOf: aPlayer.
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck on: aBoard winnedWhenReach: aSpinNumber [
	diceCup := aDiceCup.
	board:= aBoard.
	players := aGroupOfPlayers.
	board placeAtTheBeggining: players.
	playersTurnIdentificator := SequenceSimulator newFrom: (aGroupOfPlayers size).
	isFinished := false.
	spinsNeededToWin := aSpinNumber.
	cardHandler:= CardHandler managing: aDeck for: players. 
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #private }
BoardGame >> lookForPlayerWhoseTurnItIs [
	^ players at: (playersTurnIdentificator findNextIndex).
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

{ #category : #'actions - effects' }
BoardGame >> repeatLastEffectAppliedOn: aPlayer [
	board repeatAt: self lastEffectAppliedOn: aPlayer.
	self endGameIfTheWinnerIs: aPlayer.

]

{ #category : #validations }
BoardGame >> validateThrowOfAPermanent: aCard by: aPlayer [
	self verifyIfItIsTheTurnOf: aPlayer.

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
