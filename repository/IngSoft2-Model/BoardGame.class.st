Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'isFinished',
		'diceCup',
		'board',
		'cardHandler',
		'lapsNeededToWin',
		'playersManager',
		'inactivePlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
BoardGame class >> errorMessageMustHaveAtLeastAPlayer [
	^ 'The board game must have at leaste ONE player'
]

{ #category : #'error messages' }
BoardGame class >> errorMessageTheAmountOfLapsMustBeGreaterThanCero [
	^ 'The board game must have at least one lap'
]

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup and: aDeck onABoardWith: fields wonWhenReach: laps [
		self verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers .
		self verifyIfLapsAreMoreThanCero: laps.
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup and: aDeck onBoardWith: fields wonWhenReach: laps.
]

{ #category : #validations }
BoardGame class >> verifyIfLapsAreMoreThanCero: laps [.
	(laps <1 ) 
		ifTrue: [ Error signal: self errorMessageTheAmountOfLapsMustBeGreaterThanCero ] .
]

{ #category : #validations }
BoardGame class >> verifyIfThereIsAtLeastOnePlayerOn: aGroupOfPlayers [ 
	(aGroupOfPlayers isEmpty ) 
		ifTrue: [ Error signal: self errorMessageMustHaveAtLeastAPlayer ] .
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

{ #category : #private }
BoardGame >> continueTurnOf: player with: sum [
	| sumOfAllDices |
	sumOfAllDices := self fieldsToMoveAfter: player obtained: sum.
	board move: player along: sumOfAllDices on: self.
	self endGameIfTheWinnerIs: player.
]

{ #category : #'actions - cards' }
BoardGame >> dealACardTo: player [ 
	cardHandler deliverACardTo:player.
]

{ #category : #private }
BoardGame >> endGameIfTheWinnerIs: player [
	| newPosition |
	newPosition := board positionOf: player.
	newPosition round > lapsNeededToWin
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
BoardGame >> errorMessagePlayerWasNeverImprisoned [
	^ 'This element was never exclude, therefore it can not be reincorporated'
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

{ #category : #actions }
BoardGame >> free: player [
	inactivePlayers
		remove: player
		ifAbsent: [ ].
	board activateTrackerOf: player.
	"Error signal: self errorMessagePlayerWasNeverImprisoned"
	
]

{ #category : #actions }
BoardGame >> free: player with: card [
	self free: player.
	cardHandler addToCardsRecord: card
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
	lapsNeededToWin := laps.
	cardHandler:= CardHandler managing: aDeck for: aGroupOfPlayers. 
	inactivePlayers := OrderedCollection new.
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #private }
BoardGame >> lookForPlayerWhoseTurnItIs [
	^ playersManager nextElement.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player sumOfAllDices |
	self verifyIfTheGameHasFinished.
	player := self lookForPlayerWhoseTurnItIs.
	sumOfAllDices := diceCup throw.
	(sumOfAllDices = diceCup max and: (self validateIfNotInJail: player))
		ifTrue:[self free: player].
	(self validateIfNotInJail: player)
		ifFalse: [ self continueTurnOf: player with: sumOfAllDices ]
]

{ #category : #actions }
BoardGame >> positionOf: player [
 ^ board positionOf: player.
	
]

{ #category : #actions }
BoardGame >> putInPrison: aPlayer [
	inactivePlayers add: aPlayer.
	board inactiveTrackerOf: aPlayer.
	
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

{ #category : #initialize }
BoardGame >> startPlayingOnABoardWith: fields with: aGroupOfPlayers [
	playersManager := Sequence newFrom: aGroupOfPlayers.
	board := Board has: fields usedBy: aGroupOfPlayers.
]

{ #category : #validations }
BoardGame >> validateIfNotInJail: player [
	^ inactivePlayers anySatisfy: [ :aPlayer | aPlayer = player ]
]

{ #category : #validations }
BoardGame >> verifyIfItIsTheTurnOf: currentPlayer [
	(currentPlayer = (playersManager actualElement)) ifFalse:[Error signal: self errorMessageCardCanNotBePlayedOutsidePlayersTurn]
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
