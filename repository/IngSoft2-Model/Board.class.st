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
Board class >> containing: fields usedOnAGameBy: players [
	self verifyIfItHasAtLeastTwo: fields.
	^self new initializeContaining: fields usedOnAGameBy: players.
]

{ #category : #'error messages' }
Board class >> errorMessageNumberOfFieldsMustBeGreaterThanOne [
 ^ 'There must be al least two fields'
]

{ #category : #validations }
Board class >> verifyIfItHasAtLeastTwo: fields [.
	(fields size < 3 ) 
		ifTrue: [ Error signal: self errorMessageNumberOfFieldsMustBeGreaterThanOne ] .
]

{ #category : #'actions - effects' }
Board >> applyAt: aBoardGame lastEffectTo: aPlayer [
	effectsHistory last effectTriggeredBy: aPlayer on: self of: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #private }
Board >> considerEffectOf: field on: aBoardGame for: player [
	| effect |
	effect := field effectTriggeredBy: player on: self of: aBoardGame.
	effectsHistory add: effect
]

{ #category : #private }
Board >> createValidTrackerFor: aPlayer standingOn: aField after: aRound [
	| newTracker |
	newTracker := Tracker
		of: aPlayer
		standingOn: aField
		after: aRound.
	newTracker := self validate: newTracker.
	^ newTracker
]

{ #category : #private }
Board >> determinateAdditionalRoundsBasingOn: totalFields [
	^ (totalFields-1) // (self numberOfFields).
	
]

{ #category : #private }
Board >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self
		lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber := oldPosition round
		+ (self determinateAdditionalRoundsBasingOn: totalFields).
	^ self
		createValidTrackerFor: player
		standingOn: newFieldNumber
		after: newRoundNumber
]

{ #category : #initialize }
Board >> initializeContaining: boardGameFields usedOnAGameBy: players [
	fields := boardGameFields.
	positionsTracker := OrderedCollection newFrom: (players collect: [ :aPlayer | Tracker of: aPlayer standingOn: 1 after: 1 ]).
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
Board >> move: player along: result on: aBoardGame [ 
	| newPosition field newFieldNumber |
	newPosition := self move: player over: result.
	newFieldNumber:= newPosition field.
	field := self searchFieldFor: newFieldNumber.
	self considerEffectOf: field on: aBoardGame for: player.
]

{ #category : #'actions - move' }
Board >> move: player over: aNumberOfFields [ 
	| newPosition oldPosition |
	oldPosition := self positionOf: player.
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	self replaceOldPositioOf: player with: newPosition.
	^ newPosition
]

{ #category : #'actions - move' }
Board >> moveAllPlayers: aNumberOfFields except: aPlayer [ 
	| playerPosition |
	playerPosition := positionsTracker detect:[:position | position player = aPlayer].
	positionsTracker  := positionsTracker reject: [ :position | position player = aPlayer ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	positionsTracker add: playerPosition .
]

{ #category : #'actions - move' }
Board >> moveAllPlayersToTheStartOfTheCurrentLap [
	positionsTracker := positionsTracker collect: [ :position | Tracker of: (position player) standingOn: 1 after: (position round) ]
	
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #actions }
Board >> orderPlayersPosition [
	^positionsTracker
		sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
	
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

{ #category : #actions }
Board >> replaceOldPositioOf: player with: newPosition [
	positionsTracker removeAllSuchThat:[:position | position player = player].
	positionsTracker add: newPosition
	
]

{ #category : #'actions - effects' }
Board >> reverseTheEffectOf: aFieldNumber [
	| effect reverseEffect |
	effect:= self searchFieldFor: aFieldNumber .
	reverseEffect:= effect reverse.
	fields at: aFieldNumber put: reverseEffect.
]

{ #category : #actions }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition
]

{ #category : #validations }
Board >> validate: aPosition [
 (aPosition round <= 0) ifTrue: [^( Tracker of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
	
]
