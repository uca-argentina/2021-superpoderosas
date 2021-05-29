Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| newPosition |
	newPosition := self findNewPositionBasedOn:  aPosition onABoardWith: aNumberOfFields.
	self at: playersPosition replace: aPosition with: newPosition.
]

{ #category : #actions }
SpeedUp >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame move: 4 thePlayerOf: aPosition.
]

{ #category : #private }
SpeedUp >> findNewFieldNumberBasedOn: aPosition and: aNumberOfFields [
	^ (aPosition field + 4) % aNumberOfFields.
]

{ #category : #private }
SpeedUp >> findNewPositionBasedOn: aPosition onABoardWith: aNumberOfFields [
	^ Position
		of: aPosition player
		standingOn: (self findNewFieldNumberBasedOn: aPosition and: aNumberOfFields)
		after:
			aPosition round
				+ (self roundNeededToBeAddedBasedOn: aPosition and: aNumberOfFields)
]

{ #category : #private }
SpeedUp >> roundNeededToBeAddedBasedOn: aPosition and: aNumberOfFields [
	^ (aPosition field + 4) // aNumberOfFields.
]
