Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDealer >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame dealACardTo: aPlayer.
]
