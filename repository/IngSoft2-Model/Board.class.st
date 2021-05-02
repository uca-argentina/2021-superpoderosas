Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfFields',
		'playingFields'
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
Board >> findInWichPositionIs: aPlayer [
	
	^ playingFields keyAtValue: (playingFields detect:[:value | value includes:aPlayer ]).
]

{ #category : #initialization }
Board >> initializeMadeUpOf: aNumberOfFields havingAtAnInitialPosition: players [
	numberOfFields := aNumberOfFields.
	playingFields:= self initializePlayingFields: players.
]

{ #category : #initialization }
Board >> initializePlayingFields: players [
	playingFields := self createFields.
	playingFields at:1 put: players.
	
	^ playingFields.
]

{ #category : #positions }
Board >> move: aPlayer along: aNumberOfFields [ 
	| actualPosition newPosition |
	actualPosition := self findInWichPositionIs: aPlayer.
	newPosition := aNumberOfFields  + actualPosition.
	self move: aPlayer from: actualPosition to: newPosition.
	
	
]

{ #category : #positions }
Board >> move: aPlayer from: oldPosition to: newPosition [.

	self remove: aPlayer from: oldPosition.
	self move: aPlayer to: newPosition.
	
]

{ #category : #positions }
Board >> move: aPlayer to: newPosition [ 
	| playersAtNewPositionBeforeTheNewPlayerArrives playersAtNewPositionAfterTheNewPlayerArrives |
	playersAtNewPositionBeforeTheNewPlayerArrives := (playingFields at: newPosition).
	playersAtNewPositionAfterTheNewPlayerArrives := OrderedCollection newFrom: playersAtNewPositionBeforeTheNewPlayerArrives.
	playersAtNewPositionBeforeTheNewPlayerArrives add: aPlayer.
	
	playingFields at: newPosition put: playersAtNewPositionAfterTheNewPlayerArrives.
	
]

{ #category : #positions }
Board >> remove: aPlayer from: oldPosition [
	| playersAtOldPositionOfCurrentPlayer |
	playersAtOldPositionOfCurrentPlayer := (playingFields at: oldPosition).
	playersAtOldPositionOfCurrentPlayer removeAllSuchThat: [ :anotherPlayer | anotherPlayer = aPlayer ].
	
	playingFields at: oldPosition put: playersAtOldPositionOfCurrentPlayer.
	
	
]
