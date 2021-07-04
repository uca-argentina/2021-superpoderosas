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

{ #category : #'error messages' }
Board class >> errorMessageNumberOfFieldsMustBeGreaterThanOne [
 ^ 'There must be al least two fields'
]

{ #category : #initialization }
Board class >> has: fields [ 
	self verifyIfItHasAtLeastTwoFields: fields.
	^self new initializeHaving: fields.
]

{ #category : #validations }
Board class >> verifyIfItHasAtLeastTwoFields: numberOfFields [.
	(numberOfFields size < 3 ) 
		ifTrue: [ Error signal: self errorMessageNumberOfFieldsMustBeGreaterThanOne ] .
]

{ #category : #'actions - effects' }
Board >> applyAt: aBoardGame lastEffectTo: aPlayer [
	effectsHistory last effectTriggeredBy: aPlayer on: self of: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #private }
Board >> considerEffecrOf: field on: aBoardGame for: player [
	| effect |
	effect := field effectTriggeredBy: player on: self of: aBoardGame.
	effectsHistory add: effect
]

{ #category : #private }
Board >> determinateAdditionalRoundsBasingOn: totalFields [
	^ (totalFields-1) // (self numberOfFields).
	
]

{ #category : #private }
Board >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newPosition newRoundNumber newFieldNumber |
	totalFields := oldPosition field + aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber :=  oldPosition round + (self determinateAdditionalRoundsBasingOn: totalFields).
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
Board >> move: player along: result on: aBoardGame [ 
	| newPosition field |
	newPosition := self move: player over: result.
	field := self searchFieldFor: newPosition.
	self considerEffecrOf: field on: aBoardGame for: player.
	self orderPlayersPosition
]

{ #category : #'actions - move' }
Board >> move: player over: aNumberOfFields [ 
	| newPosition oldPosition |
	oldPosition := self positionOf: player.
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	positionsTracker removeAllSuchThat:[:position | position player = player].
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
Board >> moveAllPlayersTo: aSpecificField [
	positionsTracker := positionsTracker collect: [ :position | Tracker of: (position player) standingOn: aSpecificField after: (position round) ]
	
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

{ #category : #actions }
Board >> replaceOldPositioOf: player with: newPosition [
	positionsTracker removeAllSuchThat:[:position | position player = player].
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
