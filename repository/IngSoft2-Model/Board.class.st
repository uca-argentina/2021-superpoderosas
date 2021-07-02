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

{ #category : #initialize }
Board >> addOrSubstractOneIfThePlayerHasChangedRound: totalFields [
	^ (totalFields-1) // (self numberOfFields).
	
]

{ #category : #initialize }
Board >> applyAt: aBoardGame lastEffectTo: aPlayer [
	effectsHistory last applyTheEffectOn: (self positionOf: aPlayer) of: self usedAt: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #initialize }
Board >> applyLastEffectTo: aPlayer [
	effectsHistory last applyTheEffectOn: (self positionOf: aPlayer) of: self.
	self orderPlayersPosition.
]

{ #category : #initialize }
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

{ #category : #initialize }
Board >> lookUpResultingFieldNumberBasingOn: totalFields [
	| aNumberOfFields |
	aNumberOfFields := self numberOfFields.
	^ totalFields = aNumberOfFields
		ifTrue: [ aNumberOfFields ]
		ifFalse: [ totalFields > 0
				ifTrue: [ totalFields % aNumberOfFields ]
				ifFalse: [aNumberOfFields + totalFields] ]
	
]

{ #category : #initialize }
Board >> move: player along: result [
	| oldPosition |
	oldPosition := self positionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition.
	self orderPlayersPosition.
]

{ #category : #initialize }
Board >> move: player along: result on: aBoardGame [
	| oldPosition |
	oldPosition := self positionOf: player.
	self move: player over: result consideringAnEffectFrom: oldPosition on: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #initialize }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := self searchFieldFor: newPosition.
	effect := field applyTheEffectOn: newPosition of: self.
	effectsHistory add: effect.
	
]

{ #category : #initialize }
Board >> move: aPlayer over: aNumberOfFields consideringAnEffectFrom: oldPosition on: aBoardGame [
	| newPosition field effect |
	newPosition := self move: aPlayer over: aNumberOfFields from: oldPosition.
	field := self searchFieldFor: newPosition.
	effect := field applyTheEffectOn: newPosition of: self usedAt: aBoardGame.
	effectsHistory add: effect.
	
]

{ #category : #initialize }
Board >> move: player over: aNumberOfFields from: oldPosition [
	| newPosition |
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	self replace: oldPosition with: newPosition.
	^ newPosition
	
]

{ #category : #initialize }
Board >> move: aNumberOfFields thePlayerOf: oldPosition [
	self move: (oldPosition player) over: aNumberOfFields from: oldPosition.
	
]

{ #category : #initialize }
Board >> moveAllPlayers: aNumberOfFields exceptThePlayerOf: aPosition [
	playersPosition  := playersPosition reject: [ :position | position=aPosition ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	playersPosition add: aPosition .
]

{ #category : #initialize }
Board >> moveAllPlayersTo: aField [
	playersPosition := playersPosition collect: [ :position | Position of: (position player) standingOn: 1 after: (position round) ]
	
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #initialize }
Board >> orderPlayersPosition [
	playersPosition
		sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
	
]

{ #category : #initialize }
Board >> placeAtTheBeggining: players [
	playersPosition := players collect: [ :aPlayer | Position of: aPlayer standingOn: 1 after: 1 ].
]

{ #category : #accessing }
Board >> playersPosition [
	^ playersPosition
]

{ #category : #initialize }
Board >> positionOf: aPlayer [
 ^ playersPosition detect: [ :aPosition | aPosition player = aPlayer].
]

{ #category : #initialize }
Board >> repeatAt: aBoardGame lastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyAt: aBoardGame lastEffectTo: aPlayer].
]

{ #category : #initialize }
Board >> repeatLastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyLastEffectTo: aPlayer ].
]

{ #category : #initialize }
Board >> replace: oldPosition with: newPosition [
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
	
]

{ #category : #initialize }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #initialize }
Board >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Position of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
	
]
