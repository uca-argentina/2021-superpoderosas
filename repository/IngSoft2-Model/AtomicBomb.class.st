Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> applyTheEffectOn: aPosition of: aBoard [

	aBoard moveAllPlayersTo: 1.
	super.
]

{ #category : #actions }
AtomicBomb >> applyTheEffectOn: newPosition of: aBoard usedAt: aBoardGame [

	aBoard moveAllPlayersTo: 1.
	super.
]
