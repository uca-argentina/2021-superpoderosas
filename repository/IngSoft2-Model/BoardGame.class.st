Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'diceCup',
		'actualPosition',
		'spinsNeededToWin',
		'winner',
		'playersPosition',
		'numberOfFields',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber [
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber.
]

{ #category : #private }
BoardGame >> addOneToPlayersTurnIdentificator [
	playersTurnIdentificator := playersTurnIdentificator +1.
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #actions }
BoardGame >> comparePositions: positionOne with: positionTwo [
	| digits |
	digits:= numberOfFields asString size.
	^ (self idOf: positionOne )> (self idOf: positionTwo).
]

{ #category : #initialize }
BoardGame >> createCollectionWithInitialPositions [
	^ players collect: [ :aPlayer | Position determinedMainlyBy: 1 andSecondlyBy: 1 has: aPlayer].
	
]

{ #category : #actions }
BoardGame >> detectPositionOf: player [
 ^playersPosition detect: [ :aPosition | aPosition player= player ].
	
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
BoardGame >> idOf: aPosition [ 
	| digits |
	digits:= numberOfFields asString size.
	^((aPosition round*(10**digits))+ aPosition field )
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	diceCup := aDiceCup.
	board:= Board size: aNumberOfFields.
	players := aGroupOfPlayers.
	isFinished := false.
	playersTurnIdentificator := 1.
	spinsNeededToWin := aSpinNumber.
	numberOfFields := aNumberOfFields.
	playersPosition:= OrderedCollection newFrom: (self createCollectionWithInitialPositions).
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #actions }
BoardGame >> move: aPlayer over: aNumberOfFields from: oldPosition [
	| newPosition newFieldNumber newRoundNumber totalFields  |
	totalFields:=(oldPosition field  + aNumberOfFields ).
	newFieldNumber:= totalFields % numberOfFields .
	newRoundNumber := oldPosition round + (totalFields // numberOfFields).
	newPosition:= Position determinedMainlyBy: newRoundNumber andSecondlyBy: newFieldNumber has: aPlayer.
	playersPosition remove: oldPosition.
	playersPosition add: newPosition.
	board applyTheEffectOn: playersPosition determinedBy: newPosition onABoardWith: numberOfFields. 
	playersPosition sort: [ :positionOne :positionTwo | self comparePositions: positionOne with: positionTwo].
	
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player oldPosition newPosition result|
	self verifyIfTheGameHasFinished.
	player:= players at: playersTurnIdentificator.
	result := diceCup throw.
	oldPosition:= self detectPositionOf: player.
	newPosition := self move: player over: result from: oldPosition.
	newPosition :=self detectPositionOf: player.
	(newPosition round > spinsNeededToWin) ifTrue: [self changeCurrentStateToFinished ].
	self updatePlayersTurnIdentificator. 
	
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #private }
BoardGame >> originalPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #accessing }
BoardGame >> ranking [
	^ playersPosition withIndexCollect: [:aPosition :index | index asString, ') ',aPosition description].
]

{ #category : #private }
BoardGame >> updatePlayersTurnIdentificator [
	(self validateIfPlayersTurnIdentificatorHasToBeTheOriginal)
        ifTrue: [ self originalPlayersTurnIdentificator]
        ifFalse: [ self addOneToPlayersTurnIdentificator].
]

{ #category : #private }
BoardGame >> validateIfPlayersTurnIdentificatorHasToBeTheOriginal [
	^ playersTurnIdentificator= self numberOfPlayers .
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
	(isFinished not) 
		ifTrue: [ Error signal: self errorMessageDoesNotHaveAWinnerYet ] .
]

{ #category : #actions }
BoardGame >> winner [
	self verifyIfTheGameIsInProcess.	
	^ playersPosition first player.
]
