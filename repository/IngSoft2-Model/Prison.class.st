Class {
	#name : #Prison,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Prison >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard block: aPlayer.
]
