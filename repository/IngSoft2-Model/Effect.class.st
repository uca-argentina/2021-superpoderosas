Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Effect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	self subclassResponsibility.
]

{ #category : #private }
Effect >> at: playersPosition replace: oldPosition with: newPosition [
	playersPosition remove: oldPosition.
	playersPosition add: newPosition
]

{ #category : #actions }
Effect >> determineNewFieldBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber onABoardWith: aNumberOfFields [ 
	((self verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber)
				ifTrue: [ ^(aNumberOfFields + auxiliarFieldNumber) ]
				ifFalse: [ ^(1 max: auxiliarFieldNumber) ])
]

{ #category : #actions }
Effect >> determineNewRoundBasingMainlyOn: auxiliarRoundNumber andSecondlyOn:auxiliarFieldNumber [
	((self verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber)
			ifTrue: [ ^ (auxiliarRoundNumber asInteger - 1) ]
			ifFalse: [ ^ auxiliarRoundNumber ])
]

{ #category : #private }
Effect >> determineRangeFromOneToSizeOf: playersPosition [
	^ 1 to: playersPosition size.
]

{ #category : #actions }
Effect >> verifyIf: auxiliarRoundNumber needsToBeChangedBasingOn: auxiliarFieldNumber [
	^ (auxiliarRoundNumber ~= 1) & (auxiliarFieldNumber <= 0)
]
