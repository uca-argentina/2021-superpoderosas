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

{ #category : #actions }
AtomicBomb >> initialize [
	reverse:= self.

]

{ #category : #actions }
AtomicBomb >> reverse [
	^reverse.

]
