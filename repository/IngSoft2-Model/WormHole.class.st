Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame move: -4 thePlayerOf: aPosition.
	super.
]

{ #category : #actions }
WormHole >> applyTheEffectOn: newPosition of: aBoard usedAt: aBoardGame [
	aBoard move: -4 thePlayerOf: newPosition.
	super.
]
