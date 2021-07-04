Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Effect >> effectTriggeredBy: aPosition on: aBoardGame [ 
	^self subclassResponsibility.
]

{ #category : #actions }
Effect >> effectTriggeredBy: newPosition on: aBoard of: aBoardGame [
	^self subclassResponsibility.
]
