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
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber [
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup on: aBoard winnedWhenReach: aSpinNumber.
]

{ #category : #private }
BoardGame >> addOrSubstractOneIfThePlayerHasChangedRound: totalFields [
	^ (totalFields-1) // numberOfFields.

]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
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

{ #category : #actions }
BoardGame >> findNewPositionWhen: aPlayer hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self
		lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber := oldPosition round
		+ (self addOrSubstractOneIfThePlayerHasChangedRound: totalFields).
	newPosition := Position
		of: aPlayer
		standingOn: newFieldNumber
		after: newRoundNumber.
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
	^ (totalFields = numberOfFields)
		ifTrue: [ numberOfFields ]
		ifFalse: [ (totalFields <= 0) ifTrue: [totalFields % numberOfFields ] ifFalse:[numberOfFields + totalFields]].
]

{ #category : #private }
BoardGame >> move: player along: result [
	| oldPosition |
	oldPosition := self detectPositionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition.
]

{ #category : #actions }
BoardGame >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition [
	| newPosition field |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := board searchFieldFor: newPosition.
	field applyTheEffectOn: newPosition of: self
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
BoardGame >> nextTurn [
	| player sumOfAllDices |
	self verifyIfTheGameHasFinished.
	player := self lookForPlayerWhoseTurnItIs.
	sumOfAllDices := diceCup throw.
	self move: player along: sumOfAllDices.
	self endGameIfTheWinnerIs: player.
	self orderPlayersPosition.
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
"yo creo que directamente retornaria playersPosition total ya esta ordenado"
	^ playersPosition withIndexCollect: [:aPosition :index | index asString, ') ',aPosition description].
]

{ #category : #private }
BoardGame >> replace: oldPosition with: newPosition [
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
]

{ #category : #validations }
BoardGame >> verifyIfItIsNotEmpty: aGroupOfPlayers [ 
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastAPlayer ] .
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
