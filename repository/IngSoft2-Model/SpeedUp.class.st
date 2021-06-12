Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> applyTheEffectOn: aPosition of: aBoardGame [

	aBoardGame move: 4 thePlayerOf: aPosition.
	super.
]
