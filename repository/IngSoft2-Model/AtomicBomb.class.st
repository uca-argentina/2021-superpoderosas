Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayersToTheBeginningOfLap.

]
