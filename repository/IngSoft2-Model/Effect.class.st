Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Effect >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	^ self subclassResponsibility
]
