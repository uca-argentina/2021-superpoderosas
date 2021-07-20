Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayersToTheBeginningOfLap.

]
