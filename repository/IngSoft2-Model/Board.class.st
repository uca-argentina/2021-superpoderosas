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
	fields := OrderedDictionary new:numberOfFields.
	"en una ordered collection podemos aplicar el remove, es por esto que se crea antes de mandarse"
	emptyField:= OrderedCollection newFrom: {}.
	1 to: numberOfFields do:[:i | fields add:(i)->emptyField].
	^fields
]

{ #category : #accessing }
Board >> findInWichPositionIs: aPlayer [
	
	^playingFields keyAtValue: (playingFields detect:[:value | value includes:aPlayer ]).
	"d := OrderedDictionary newFrom: { 1 -> {'hola' . 'male'} . 3 -> {'hey'} . 5 ->{'juana' . 'valen'}}.
	d keyAtValue: (d detect:[:value | value includes:'hey']). FUNCAAAA"
]

{ #category : #initialization }
Board >> initializeMadeUpOf: aNumberOfFields havingAtAnInitialPosition: players [
	numberOfFields := aNumberOfFields.
	playingFields:= self createFields: players.
]

{ #category : #initialization }
Board >> initializePlayingFields: players [
	playingFields := self createFields.
	playingFields at:1 put: players.
	^playingFields
]

{ #category : #positions }
Board >> move: player alongTheBoardSomeFields: aNumberOfFields [ 
	| actualPosition newPosition |
	actualPosition := self findInWichPositionIs: player.
	newPosition := aNumberOfFields  + actualPosition.
	self move: player from: actualPosition to: newPosition.
	
	
]

{ #category : #positions }
Board >> move: player from: oldPosition to: newPosition [.
	self remove:player from: oldPosition.
	self move: player to: newPosition .
	
]

{ #category : #positions }
Board >> move: player to: newPosition [ 
	(playingFields at: newPosition) add:player.
	
]

{ #category : #positions }
Board >> remove:player from: oldPosition [.
	(playingFields at: oldPosition) removeAllSuchThat: [ :aPlayer | aPlayer = player ].
	
	
]
