Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfFields',
		'playingFields',
		'arr',
		'playersAtFirstField',
		'firstFieldInitialize',
		'playersPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> madeUpOf: aNumberOfFields havingAtAnInitialPosition: players [.
	^self new initializeMadeUpOf: aNumberOfFields havingAtAnInitialPosition: players.
]

{ #category : #initialization }
Board >> createFields [
	| fields emptyField |
	fields := OrderedDictionary new: numberOfFields.
	emptyField:= OrderedCollection new.
	1 to: numberOfFields do:[:i | fields add:(i)->emptyField].
	^fields.
]

{ #category : #accessing }
Board >> findInWhichPositionIs: aPlayer [
	
	^ playingFields keyAtValue: (playingFields detect:[:value | value includes:aPlayer ]).
]

{ #category : #accessing }
Board >> findPlayersRanking [
	playersPosition:= OrderedCollection new.
	playingFields valuesDo: [ :aValue |aValue do: [ :aPlayer | playersPosition add: (aPlayer name , ': ', (playingFields keyAtValue: aValue) asString )]].
	playersPosition:= (playersPosition reversed)  withIndexCollect: [:rank :index | ( index asString),') ',rank].
	^playersPosition.
	
]

{ #category : #initialization }
Board >> initializeMadeUpOf: aNumberOfFields havingAtAnInitialPosition: players [
	numberOfFields := aNumberOfFields.
	playingFields:= self initializePlayingFields: players.
]

{ #category : #initialization }
Board >> initializePlayingFields: players [
	playingFields := self createFields.
	firstFieldInitialize := OrderedCollection newFrom: players.
	playingFields at:1 put: firstFieldInitialize.
	
	^ playingFields.
]

{ #category : #private }
Board >> move: aPlayer from: oldPosition to: newPosition [.

	self remove: aPlayer from: oldPosition.
	self move: aPlayer to: newPosition.
	
]

{ #category : #positions }
Board >> move: aPlayer over: aNumberOfFields [
	| actualPosition newPosition estimatedPosition |
	actualPosition := self findInWhichPositionIs: aPlayer.
	estimatedPosition := aNumberOfFields  + actualPosition.
	newPosition := estimatedPosition % numberOfFields.
	(estimatedPosition//numberOfFields = 1) ifTrue: [aPlayer startsANewSpin].
	self move: aPlayer from: actualPosition to: newPosition.
	
	
	
	
	
]

{ #category : #private }
Board >> move: aPlayer to: newPosition [ 
	| playersAtNewPositionBeforeTheNewPlayerArrives playersAtNewPositionAfterTheNewPlayerArrives |
	playersAtNewPositionBeforeTheNewPlayerArrives := (playingFields at: newPosition).
	playersAtNewPositionAfterTheNewPlayerArrives := OrderedCollection newFrom: playersAtNewPositionBeforeTheNewPlayerArrives.
	playersAtNewPositionAfterTheNewPlayerArrives add: aPlayer.
	
	playingFields at: newPosition put: playersAtNewPositionAfterTheNewPlayerArrives.
]

{ #category : #accessing }
Board >> numberOfFields [
	^ numberOfFields
]

{ #category : #private }
Board >> remove: aPlayer from: oldPosition [
	| playersAtOldPositionOfCurrentPlayer |
	playersAtOldPositionOfCurrentPlayer := (playingFields at: oldPosition).
	playersAtOldPositionOfCurrentPlayer removeAllSuchThat: [ :anotherPlayer | anotherPlayer = aPlayer ].
	
	playingFields at: oldPosition put: playersAtOldPositionOfCurrentPlayer.
	
	
]
