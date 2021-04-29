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
	| fields |
	OrderedDictionary new:numberOfFields.
	fields := OrderedDictionary new:numberOfFields.
	1 to: numberOfFields do:[:i | fields add:(i)->{}].
	^fields
]

{ #category : #accessing }
Board >> findInWichPositionIs: aPlayer [
	playingFields detect:[:i | (playingFields at:i) contains:aPlayer ]
	"Deberíamos hacer andar lo siguiente para obtener la posicion del jugador
	^playerPosition := dic detect:[:i | (dic at:i) contains: aPlayer]. "
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
	self removePlayerFrom: oldPosition.
	self movePlayerTo: newPosition .
	
]
