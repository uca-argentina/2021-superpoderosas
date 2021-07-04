Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields',
		'effectsHistory',
		'positionsTracker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> has: fields [ 
	^self new initializeHaving: fields.
]

{ #category : #private }
Board >> addOrSubstractOneIfThePlayerHasChangedRound: totalFields [
	^ (totalFields-1) // (self numberOfFields).
	
]

{ #category : #'actions - effects' }
Board >> applyAt: aBoardGame lastEffectTo: aPlayer [
	effectsHistory last effectTriggeredBy: aPlayer on: self of: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #'actions - effects' }
Board >> applyLastEffectTo: aPlayer [
	effectsHistory last effectTriggeredBy: (self positionOf: aPlayer) on: self.
	self orderPlayersPosition.
]

{ #category : #private }
Board >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber :=  oldPosition round + (self addOrSubstractOneIfThePlayerHasChangedRound: totalFields).
	newPosition := Tracker of: player standingOn: newFieldNumber after: newRoundNumber.
	newPosition := self validate: newPosition.
	^ newPosition
	
]

{ #category : #initialize }
Board >> initializeHaving: someFields [ 
	fields := someFields .
	positionsTracker:= OrderedCollection new.
	effectsHistory:= OrderedCollection new.
]

{ #category : #private }
Board >> lookUpResultingFieldNumberBasingOn: totalFields [
	| aNumberOfFields |
	aNumberOfFields := self numberOfFields.
	^ totalFields = aNumberOfFields
		ifTrue: [ aNumberOfFields ]
		ifFalse: [ totalFields > 0
				ifTrue: [ totalFields % aNumberOfFields ]
				ifFalse: [aNumberOfFields + totalFields] ]
	
]

{ #category : #'actions - move' }
Board >> move: player along: result [
	| oldPosition |
	oldPosition := self positionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition.
	self orderPlayersPosition.
]

{ #category : #'actions - move' }
Board >> move: player along: result on: aBoardGame [
	| oldPosition |
	oldPosition := self positionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition on: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #'actions - move' }
Board >> move: player over: aNumberOfFields [ 
	| newPosition oldPosition |
	oldPosition := (positionsTracker detect:[:position | position player = player]).
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	self replace: oldPosition with: newPosition.
	^ newPosition
	
]

{ #category : #private }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields.
	field := self searchFieldFor: newPosition.
	effect := field effectTriggeredBy: newPosition on: self.
	effectsHistory add: effect.
	
]

{ #category : #private }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition on: aBoardGame [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields.
	field := self searchFieldFor: newPosition.
	effect := field effectTriggeredBy: aPlayer on: self of: aBoardGame.
	effectsHistory add: effect.
	
]

{ #category : #'actions - move' }
Board >> moveAllPlayers: aNumberOfFields except: aPlayer [
	| playerPosition |
	playerPosition := positionsTracker detect:[:position | position player = aPlayer].
	positionsTracker  := positionsTracker reject: [ :position | position player = aPlayer ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	positionsTracker add: playerPosition .
	"playersPosition = positionsTracker remove[:position | position player = a Player]
	positionsTracker:= positionsTracker collect:[ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	positionsTracker add: playerPosition
	"
]

{ #category : #'actions - move' }
Board >> moveAllPlayersTo: aField [
	positionsTracker := positionsTracker collect: [ :position | Tracker of: (position player) standingOn: 1 after: (position round) ]
	
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #actions }
Board >> orderPlayersPosition [
	positionsTracker
		sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
	
]

{ #category : #'actions - move' }
Board >> placeAtTheBeggining: players [
	positionsTracker := OrderedCollection newFrom: (players collect: [ :aPlayer | Tracker of: aPlayer standingOn: 1 after: 1 ]).
]

{ #category : #accessing }
Board >> playersPosition [
	^ positionsTracker
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
 ^ positionsTracker detect: [ :aPosition | aPosition player = aPlayer].
]

{ #category : #'actions - effects' }
Board >> repeatAt: aBoardGame lastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyAt: aBoardGame lastEffectTo: aPlayer].
]

{ #category : #'actions - effects' }
Board >> repeatLastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyLastEffectTo: aPlayer ].
]

{ #category : #actions }
Board >> replace: oldPosition with: newPosition [
	positionsTracker remove: oldPosition.
	positionsTracker add: newPosition
	
]

{ #category : #actions }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #validations }
Board >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Tracker of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
	
]
