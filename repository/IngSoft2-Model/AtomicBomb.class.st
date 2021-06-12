Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBomb >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame moveAllPlayersTo: 1.
	super.
]
