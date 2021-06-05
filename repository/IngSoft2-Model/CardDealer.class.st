Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDealer >> applyTheEffectOn: aPosition of: aBoardGame [ 
	aBoardGame deal: 'card1' toPlayerOf: aPosition.
]
