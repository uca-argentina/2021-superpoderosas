Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| newPosition |
	newPosition := self findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields.

	self at: playersPosition replace: aPosition with: newPosition.
]

{ #category : #actions }
WormHole >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame move: -4 thePlayerOf: aPosition.
]

{ #category : #actions }
WormHole >> findNewFieldNumberBasedOn: aPosition and: aNumberOfFields [
	^ aPosition field asInteger - 4.
]

{ #category : #actions }
WormHole >> findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields [
	| auxiliarRoundNumber auxiliarFieldNumber |
	auxiliarFieldNumber := self
		findNewFieldNumberBasedOn: aPosition
		and: aNumberOfFields.
	auxiliarRoundNumber := aPosition round.
	^ Position
		of: aPosition player
		standingOn:
			(self
				determineNewFieldBasingMainlyOn: auxiliarRoundNumber
				andSecondlyOn: auxiliarFieldNumber
				onABoardWith: aNumberOfFields)
		after:
			(self
				determineNewRoundBasingMainlyOn: auxiliarRoundNumber
				andSecondlyOn: auxiliarFieldNumber)
]
