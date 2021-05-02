Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'isFinished',
		'playersTurnIdentificator',
		'numberOfFields',
		'diceCup',
		'result',
		'actualPosition',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields [ 
		^ self new initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields.
]

{ #category : #private }
BoardGame >> addOneToPlayersTurnIdentificator [
	playersTurnIdentificator := playersTurnIdentificator +1.
]

{ #category : #private }
BoardGame >> changeCurrentStateToFinished [
	isFinished := true.
]

{ #category : #private }
BoardGame >> determinateNewPositionBasedOn: aNumberOfFieldsToMoveAlong and: aPositionOnTheBoard [
	| newPlayerPosition |
	"eliminar"
	newPlayerPosition := (self numberOfFields) min:(aNumberOfFieldsToMoveAlong + aPositionOnTheBoard).
	self verifyIfTheFinishLineIsAt: newPlayerPosition.
	^ newPlayerPosition.
	
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

{ #category : #accessing }
BoardGame >> findPlayersRanking [
	^ board findPlayersRanking.
]

{ #category : #initialize }
BoardGame >> initializePlayedBy: aGroupOfPlayers using: aDiceCup onABoardOf: aNumberOfFields [
	self verifyIfItIsNotEmpty: aGroupOfPlayers .
	
	diceCup := aDiceCup.
	players := aGroupOfPlayers.
	numberOfFields :=aNumberOfFields.
	isFinished := false.
	playersTurnIdentificator := 1.
	"esta bien que se cree aca el board ya que sino deberíamos pasar dos veces por paran a players a board y a board game cosa que queda desprolija"
	board:= Board madeUpOf: aNumberOfFields havingAtAnInitialPosition: players.
]

{ #category : #accessing }
BoardGame >> isFinished [
	^ isFinished.
]

{ #category : #actions }
BoardGame >> nextTurn [
	| player |
	self verifyIfTheGameHasFinished.
	player:= players at: playersTurnIdentificator.
	result := diceCup throw.
	board move: player along: result.
	self updatePlayersTurnIdentificator. 
	
]

{ #category : #accessing }
BoardGame >> numberOfFields [
	^ numberOfFields
]

{ #category : #actions }
BoardGame >> numberOfPlayers [
	^ players size.
]

{ #category : #private }
BoardGame >> originalPlayersTurnIdentificator [
	playersTurnIdentificator:= 1.
]

{ #category : #actions }
BoardGame >> playersRanking [
	"cambiar adaptandolo al dic"
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition  withIndexCollect: [:aPlayer :anIndex | self textWith: anIndex andTheNameOf: aPlayer ].
]

{ #category : #private }
BoardGame >> textWith: aRank andTheNameOf: aPlayer [ 
	"eliminar"
	^ (aRank asString , ': ' , aPlayer name ).
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
BoardGame >> verifyIfTheFinishLineIsAt: aPosition [ 
	(aPosition = numberOfFields) ifTrue:[self changeCurrentStateToFinished].
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
	^ self groupOfPlayersSortedInAscendingOrderByActualPosition first.
]
