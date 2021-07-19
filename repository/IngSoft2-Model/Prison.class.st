Class {
	#name : #Prison,
	#superclass : #Fields,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Prison >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame putInPrison: aPlayer.
]
