Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayersToTheStartOfTheCurrentLap.

]

{ #category : #initialization }
AtomicBomb >> initialize [
	reverse:= self.
]

{ #category : #accessing }
AtomicBomb >> reverse [
	^ reverse.
]
