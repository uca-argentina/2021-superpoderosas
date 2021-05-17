Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleEffect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	| newPosition auxiliarFieldNumber auxiliarRoundNumber |
	auxiliarFieldNumber := aPosition field asInteger - 4.
	auxiliarRoundNumber := aPosition round.
	"hacer extract method"
	newPosition := Position
		determinedMainlyBy: (self determineNewRoundBasingMainlyOn: auxiliarRoundNumber andSecondlyOn: auxiliarFieldNumber)
		andSecondlyBy: (self determineNewFieldBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber onABoardWith: aNumberOfFields )
		has: aPosition player.
	self at: playersPosition replace: aPosition with: newPosition
]

{ #category : #actions }
WormHoleEffect >> determineNewFieldBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber onABoardWith: aNumberOfFields [ 
	((self verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber)
				ifTrue: [ ^(aNumberOfFields + auxiliarFieldNumber) ]
				ifFalse: [ ^(1 max: auxiliarFieldNumber) ])
]

{ #category : #actions }
WormHoleEffect >> determineNewRoundBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber [
	((self verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber)
			ifTrue: [ ^ (auxiliarRoundNumber asInteger - 1) ]
			ifFalse: [ ^ auxiliarRoundNumber ])
]

{ #category : #actions }
WormHoleEffect >> verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber [
	^ auxiliarRoundNumber ~= 1 & (auxiliarFieldNumber <= 0)
]
