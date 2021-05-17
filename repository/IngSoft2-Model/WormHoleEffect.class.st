Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| newPosition |
	newPosition := self findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields.

	self at: playersPosition replace: aPosition with: newPosition.
]

{ #category : #actions }
WormHoleEffect >> findNewFieldNumberBasedOn: aPosition and: aNumberOfFields [
	^ aPosition field asInteger - 4.
]

{ #category : #actions }
WormHoleEffect >> findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields [
	| auxiliarRoundNumber auxiliarFieldNumber |
	auxiliarFieldNumber := self findNewFieldNumberBasedOn: aPosition and: aNumberOfFields.
	auxiliarRoundNumber := aPosition round.
	^ Position
		determinedMainlyBy: (self determineNewRoundBasingMainlyOn: auxiliarRoundNumber andSecondlyOn: auxiliarFieldNumber)
		andSecondlyBy: (self determineNewFieldBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber onABoardWith: aNumberOfFields )
		has: aPosition player.
]
