Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Effect >> applyTheEffectOn: aPosition of: aBoardGame [ 
	^self subclassResponsibility.
]

{ #category : #actions }
Effect >> applyTheEffectOn: newPosition of: aBoard usedAt: aBoardGame [
	^self subclassResponsibility.
]
