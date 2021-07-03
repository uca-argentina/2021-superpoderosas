Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields',
		'playersPosition',
		'effectsHistory'
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
	effectsHistory last applyTheEffectOn: (self positionOf: aPlayer) of: self usedAt: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #'actions - effects' }
Board >> applyLastEffectTo: aPlayer [
	effectsHistory last applyTheEffectOn: (self positionOf: aPlayer) of: self.
	self orderPlayersPosition.
]

{ #category : #private }
Board >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber :=  oldPosition round + (self addOrSubstractOneIfThePlayerHasChangedRound: totalFields).
	newPosition := Position of: player standingOn: newFieldNumber after: newRoundNumber.
	newPosition := self validate: newPosition.
	^ newPosition
	
]

{ #category : #initialize }
Board >> initializeHaving: someFields [ 
	fields := someFields .
	playersPosition:= OrderedCollection new.
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

{ #category : #private }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := self searchFieldFor: newPosition.
	effect := field applyTheEffectOn: newPosition of: self.
	effectsHistory add: effect.
	
]

{ #category : #private }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition on: aBoardGame [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := self searchFieldFor: newPosition.
	effect := field applyTheEffectOn: newPosition of: self usedAt: aBoardGame.
	effectsHistory add: effect.
	
]

{ #category : #private }
Board >> move: player over: aNumberOfFields from: oldPosition [
	| newPosition |
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	self replace: oldPosition with: newPosition.
	^ newPosition
	
]

{ #category : #'actions - move' }
Board >> move: aNumberOfFields thePlayerOf: oldPosition [
	self move: (oldPosition player) over: aNumberOfFields from: oldPosition.
	
]

{ #category : #'actions - move' }
Board >> moveAllPlayers: aNumberOfFields exceptThePlayerOf: aPosition [
	playersPosition  := playersPosition reject: [ :position | position=aPosition ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	playersPosition add: aPosition .
]

{ #category : #'actions - move' }
Board >> moveAllPlayersTo: aField [
	playersPosition := playersPosition collect: [ :position | Position of: (position player) standingOn: 1 after: (position round) ]
	
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #actions }
Board >> orderPlayersPosition [
	playersPosition
		sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
	
]

{ #category : #'actions - move' }
Board >> placeAtTheBeggining: players [
	playersPosition := players collect: [ :aPlayer | Position of: aPlayer standingOn: 1 after: 1 ].
]

{ #category : #accessing }
Board >> playersPosition [
	^ playersPosition
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
 ^ playersPosition detect: [ :aPosition | aPosition player = aPlayer].
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
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
	
]

{ #category : #actions }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #validations }
Board >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Position of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
	
]
