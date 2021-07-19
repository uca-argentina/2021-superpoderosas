Class {
	#name : #Fields,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Fields >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	^ self subclassResponsibility
]
