Class {
	#name : #Repetition,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repetition >> actAt: aBoardGame [
	aBoardGame repeatlastEffectApplied.
]

{ #category : #actions }
Repetition >> actAt: aBoardGame on: aPlayer [ 
	aBoardGame repeatlastEffectAppliedOn:aPlayer.
]
