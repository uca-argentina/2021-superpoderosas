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
