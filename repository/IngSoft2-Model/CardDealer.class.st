Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDealer >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame dealACardTo: aPlayer.
]
