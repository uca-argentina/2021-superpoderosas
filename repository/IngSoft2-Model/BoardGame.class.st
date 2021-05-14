Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'diceCup',
		'result',
		'actualPosition',
		'board',
		'spinsNeededToWin',
		'winner',
		'playersPosition',
		'numberOfFields'
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

{ #category : #'as yet unclassified' }
BoardGame >> comparePositions [
	self shouldBeImplemented.
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
BoardGame >> findInWhichPositionIs: aPlayer [ 
	^ board findInWhichPositionIs: aPlayer.
]

{ #category : #accessing }
BoardGame >> findPlayersRanking [
	^board playersRanking.
]

{ #category : #actions }
BoardGame >> idOf: aPosition [ 
	| digits |
	digits:= numberOfFields asString size.
	^((aPosition round *(10**(digits-1)))+ aPosition field )
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields winnedWhenReach: aSpinNumber [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	isFinished := false.
	playersTurnIdentificator := 1.
	spinsNeededToWin := aSpinNumber.
	numberOfFields := aNumberOfFields.
	"winner := nil."
	"board:= Board madeUpOf: aNumberOfFields havingAtAnInitialPosition: players."
	playersPosition:= OrderedCollection newFrom: (self createCollectionWithInitialPositions).
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #actions }
BoardGame >> knowsInWhichSpinIs: aPlayer [ 
	^ aPlayer spin.
]

{ #category : #actions }
BoardGame >> move: aPlayer over: aNumberOfFields [ 
	| oldPosition newPosition |
	oldPosition:=playersPosition detect: [ :aPosition | aPosition player= aPlayer ].
	newPosition:= Position determinedMainlyBy: (oldPosition round) andSecondlyBy: (oldPosition field  + aNumberOfFields ) has: aPlayer. 
	playersPosition remove: oldPosition.
	playersPosition add: newPosition.
	playersPosition sort: [ :positionOne :positionTwo | self comparePositions: positionOne with: positionTwo].
	
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player |
	self verifyIfTheGameHasFinished.
	player:= players at: playersTurnIdentificator.
	result := diceCup throw.
	"board move: player over: result."
	self move: player over: result.
	((self spinOf: player ) > spinsNeededToWin) ifTrue: [self changeCurrentStateToFinished ].
	self updatePlayersTurnIdentificator. 
	
]

{ #category : #actions }
BoardGame >> numberOfFields [
	^ board numberOfFields. 
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #private }
BoardGame >> originalPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #accesing }
BoardGame >> ranking [
	^ playersPosition withIndexCollect: [:aPosition :index | index asString, ') ',aPosition description].
]

{ #category : #actions }
BoardGame >> spinOf: aPlayer [
	| aPosition |
	aPosition:= playersPosition detect: [:position | position player= aPlayer ].
	^ aPosition round.
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
	^ winner.
]
