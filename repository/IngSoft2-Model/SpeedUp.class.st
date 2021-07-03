Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> applyTheEffectOn: aPosition of: aBoard [

	aBoard move: 4 thePlayerOf: aPosition.
	super.
]

{ #category : #actions }
SpeedUp >> applyTheEffectOn: newPosition of: aBoard usedAt: aBoardGame [
	aBoard move: 4 thePlayerOf: newPosition.
	super.
]
