Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields',
		'effectsHistory',
		'trackers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'error messages' }
Board class >> errorMessageNumberOfFieldsMustBeGreaterThanOne [
 ^ 'There must be al least two fields'
]

{ #category : #initialization }
Board class >> has: fields usedBy: players [.
	self verifyIfItHasAtLeastTwoFields: fields.
	^self new initializeHaving: fields usedBy:players.
]

{ #category : #validations }
Board class >> verifyIfItHasAtLeastTwoFields: numberOfFields [.
	(numberOfFields size < 3 ) 
		ifTrue: [ Error signal: self errorMessageNumberOfFieldsMustBeGreaterThanOne ] .
]

{ #category : #'actions - effects' }
Board >> add: effect on: fieldNumber [
	| oldField effects |
	oldField := fields at: fieldNumber.
	effects := self add: effect toEffectsFrom: oldField.
	self replaceFieldOf: fieldNumber withFieldAffectedBy: effects.
]

{ #category : #private }
Board >> add: effect toEffectsFrom:oldField [
	| effects |
	effects:= oldField effects.
	effects add: effect.
	^effects
]

{ #category : #'actions - effects' }
Board >> applyAt: aBoardGame lastEffectTo: aPlayer [
	effectsHistory last effectTriggeredBy: aPlayer on: self of: aBoardGame.
	self orderPlayersPosition.
]

{ #category : #'actions - prison' }
Board >> block: player [
	| playerTracker |
	playerTracker := self positionOf: player.
	trackers remove: playerTracker.
	trackers add: (Tracker of: player standingOn: (playerTracker field)  after:  (playerTracker round) definedBy: BlockedCondition new ).
]

{ #category : #private }
Board >> considerEffectOf: field on: aBoardGame for: player [
	| effect |
	effect := field effectTriggeredBy: player on: self of: aBoardGame.
	effectsHistory add: effect.
]

{ #category : #private }
Board >> determinateAdditionalRoundsBasingOn: totalFields [
	^ (totalFields-1) // (self numberOfFields).
	
]

{ #category : #'error messages' }
Board >> errorMessagePlayerWasNeverBlocked [
	^ 'A Freedom card can not be played on a player who was never blocked'
]

{ #category : #private }
Board >> findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition [
	| totalFields newRoundNumber newFieldNumber |
	totalFields:= oldPosition findFieldAfterIntentionToMove: aNumberOfFields.
	newFieldNumber := self lookUpResultingFieldNumberBasingOn: totalFields.
	newRoundNumber := oldPosition round + (self determinateAdditionalRoundsBasingOn: totalFields).
	^ self
		generateValidTrackerFor: player
		standingOn: newFieldNumber
		after: newRoundNumber
		determinedBy: oldPosition status.
]

{ #category : #private }
Board >> generateValidTrackerFor: player standingOn: newFieldNumber after: newRoundNumber determinedBy: status [
	| newPosition |
	newPosition := Tracker of: player standingOn: newFieldNumber after: newRoundNumber definedBy: status.
	newPosition := self validateIfPlayerShouldBeAtTheBeginningBasingOn: newPosition.
	^ newPosition
]

{ #category : #initialize }
Board >> initializeHaving: someFields usedBy:players [.
	fields := someFields .
	effectsHistory:= OrderedCollection new.
	self placeAtTheBeggining: players.
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
Board >> move: player along: result on: boardGame [ 
	| newPosition field |
	newPosition := self move: player over: result.
	field := self searchFieldFor: newPosition.
	self considerEffectOf: field on: boardGame for: player.
]

{ #category : #'actions - move' }
Board >> move: player over: aNumberOfFields [
	| oldPosition newPosition |
	oldPosition := self positionOf: player.
	newPosition := self findNewPositionWhen: player hasMoved: aNumberOfFields from: oldPosition.
	self replaceOldPositioOf: player with: newPosition.
	^ newPosition.
]

{ #category : #'actions - move' }
Board >> moveAllPlayers: aNumberOfFields except: aPlayer [ 
	| playerPosition |
	playerPosition := trackers detect:[:position | position player = aPlayer].
	trackers  := trackers reject: [ :position | position player = aPlayer ] thenCollect: [ :position | self findNewPositionWhen: (position player) hasMoved: aNumberOfFields from: position].
	trackers add: playerPosition .
]

{ #category : #'actions - move' }
Board >> moveAllPlayersToTheBeginningOfLap [
	trackers := trackers collect: [ :position | Tracker of: (position player) standingOn: (position resetFieldNumber) after: (position round) ]
]

{ #category : #accessing }
Board >> numberOfFields [
	 ^ fields size.
]

{ #category : #actions }
Board >> orderPlayersPosition [
	^ trackers sort: [ :aPosition :anotherPosition | aPosition >= anotherPosition ]
	
]

{ #category : #private }
Board >> placeAtTheBeggining: players [
	trackers := OrderedCollection newFrom: (players collect: [ :aPlayer | Tracker of: aPlayer standingOn: 1 after: 1 ]).
]

{ #category : #accessing }
Board >> positionOf: aPlayer [
	^ trackers
		detect: [ :aPosition | aPosition player = aPlayer ]
	
]

{ #category : #'actions - effects' }
Board >> remove: effect from: fieldNumber [
	| oldField  effects|
	oldField:= fields at: fieldNumber.
	effects:= self remove: effect fromEffectsOf:oldField.
	self replaceFieldOf: fieldNumber withFieldAffectedBy: effects.
]

{ #category : #private }
Board >> remove: effect fromEffectsOf:oldField [
	| effects |
	effects:= oldField effects.
	effects remove: effect.
	^effects
]

{ #category : #'actions - effects' }
Board >> repeatAt: aBoardGame lastEffectAppliedOn: aPlayer [
	effectsHistory isEmpty
		ifFalse:
			[ self applyAt: aBoardGame lastEffectTo: aPlayer].
]

{ #category : #private }
Board >> replaceFieldOf: fieldNumber withFieldAffectedBy: effects [
	| newField |
	newField := Field affectedBy: effects.
	fields at: fieldNumber put: newField
]

{ #category : #actions }
Board >> replaceOldPositioOf: player with: newPosition [
	trackers removeAllSuchThat:[:position | position player = player].
	trackers add: newPosition
	
]

{ #category : #actions }
Board >> searchFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #'actions - prison' }
Board >> unblock: player [
	| playerTracker |
	playerTracker:= self positionOf: player.
	trackers remove: playerTracker.
	trackers add: (Tracker of: player standingOn: (playerTracker field)  after:  (playerTracker round)).
]

{ #category : #'actions - prison' }
Board >> unblockBlocked: player [
   self validateIfPlayerIsBlocked: player.
	self unblock: player.
]

{ #category : #'error messages' }
Board >> validateIfPlayerIsBlocked: player [
	((self positionOf: player) isBlocked)
		ifFalse: [ Error signal: self errorMessagePlayerWasNeverBlocked ]
]

{ #category : #validations }
Board >> validateIfPlayerShouldBeAtTheBeginningBasingOn: aPosition [
 (aPosition round <= 0) ifTrue: [^( Tracker of: (aPosition player) standingOn: 1 after: 1)] ifFalse:[^aPosition].
	
]
