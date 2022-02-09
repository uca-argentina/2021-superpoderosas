Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'diceCup',
		'board',
		'cardHandler',
		'lapsToWin',
		'playersTurnSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageABoardGameMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame class >> errorMessageABoardGameMustHaveAtLeastOneLap [
	^ 'The board game must have at leaste one lap'
]

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: laps [
		self verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers .
		self verifyIfThereIsAtLeastOne: laps.
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck onBoardWith: fields wonWhenReach: laps.
]

{ #category : #validations }
BoardGame class >> verifyIfThereIsAtLeastOne: laps [.
	(laps <1 ) 
		ifTrue: [ Error signal: self errorMessageABoardGameMustHaveAtLeastOneLap ] .
]

{ #category : #validations }
BoardGame class >> verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers [ 
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageABoardGameMustHaveAtLeastAPlayer ] .
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
	newPosition round > lapsToWin
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
	^ sumOfAllDices
		+ (self fieldsToMoveIndicatedByInfluentialCardsOf: player)
]

{ #category : #'actions - cards' }
BoardGame >> fieldsToMoveIndicatedByInfluentialCardsOf: player [
	| playerInfluentialCards |
	playerInfluentialCards:= cardHandler influentialCardsOf: player.
	^(playerInfluentialCards sumNumbers: [ :aCard | aCard action ])
]

{ #category : #'actions - cards' }
BoardGame >> influentialCardsOf: aPlayer [
	^ cardHandler influentialCardsOf: aPlayer.
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck onBoardWith: fields wonWhenReach: laps [
	diceCup := aDiceCup.
	self startPlayingOnABoardWith: fields with: aGroupOfPlayers.
	isFinished := false.
	lapsToWin := laps.
	cardHandler:= CardHandler managing: aDeck for: players. 
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #private }
BoardGame >> lookForPlayerWhoseTurnItIs [
	^ playersTurnSequence nextElement.
]

{ #category : #'actions - effects' }
BoardGame >> moveAsManyFieldsAsCardsInHandHas: aPlayer [
	| aNumberOfFields |
	aNumberOfFields:= (self cardsInHandOf: aPlayer) size.
	board move: aPlayer over: aNumberOfFields.

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
]

{ #category : #accessing }
BoardGame >> players [
	^ players
]

{ #category : #actions }
BoardGame >> positionOf: player [
 ^ board positionOf: player.
	
]

{ #category : #accessing }
BoardGame >> ranking [
	^ board orderPlayersPosition.
]

{ #category : #'actions - effects' }
BoardGame >> repeatLastEffectAppliedOn: aPlayer [
	board repeatAt: self lastEffectAppliedOn: aPlayer.
	self endGameIfTheWinnerIs: aPlayer.

]

{ #category : #'actions - effects' }
BoardGame >> reverseTheEffectOf: aField [
	board reverseTheEffectOf: aField.

]

{ #category : #initialize }
BoardGame >> startPlayingOnABoardWith: fields with: aGroupOfPlayers [
	players:= aGroupOfPlayers.
	playersTurnSequence := Sequence newFrom: aGroupOfPlayers.
	board := Board containing: fields usedOnAGameBy: aGroupOfPlayers.
]

{ #category : #validations }
BoardGame >> validateThrownOfAPermanentCardBy: aPlayer [
	self verifyIfItIsTheTurnOf: aPlayer.

]

{ #category : #validations }
BoardGame >> verifyIfItIsTheTurnOf: currentPlayer [
	(currentPlayer = playersTurnSequence actualElement) ifFalse:[Error signal: self errorMessageCardCanNotBePlayedOutsidePlayersTurn]
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
	^ (board orderPlayersPosition) first player.
]
