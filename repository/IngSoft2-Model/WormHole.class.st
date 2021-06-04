Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame move: -4 thePlayerOf: aPosition.
]
