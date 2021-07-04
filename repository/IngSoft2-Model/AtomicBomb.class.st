Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> effectTriggeredBy: player on: aBoard [
	aBoard moveAllPlayersTo: 1.
	super.
]

{ #category : #actions }
AtomicBomb >> effectTriggeredBy: player on: aBoard of: aBoardGame [
	aBoard moveAllPlayersTo: 1.
	super.
]
