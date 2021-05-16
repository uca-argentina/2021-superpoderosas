Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| newPosition |
	newPosition := self findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields .
	self at: playersPosition replace: aPosition with: newPosition
]

{ #category : #private }
SpeedUpEffect >> at: playersPosition replace: aPosition with: newPosition [
	playersPosition remove: aPosition.
	playersPosition add: newPosition
]

{ #category : #private }
SpeedUpEffect >> findNewFieldNumberBasedOn: aPosition and: aNumberOfFields [
	^ (aPosition field + 4) % aNumberOfFields
]

{ #category : #private }
SpeedUpEffect >> findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields [
	^ Position
		determinedMainlyBy: aPosition round + (self roundNeededToBeAddedBasedOn: aPosition and: aNumberOfFields)
		andSecondlyBy: (self findNewFieldNumberBasedOn: aPosition and: aNumberOfFields)
		has: aPosition player
]

{ #category : #private }
SpeedUpEffect >> roundNeededToBeAddedBasedOn: aPosition and: aNumberOfFields [
	^ (aPosition field + 4) // aNumberOfFields
]
