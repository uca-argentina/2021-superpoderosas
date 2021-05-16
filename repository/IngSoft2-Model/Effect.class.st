Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Effect >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [ 
	self subclassResponsibility.
]
