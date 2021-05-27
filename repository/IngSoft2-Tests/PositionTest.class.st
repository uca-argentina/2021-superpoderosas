Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testAPositionHasAFieldNumberAndRoundNumber [
	| aPosition |
	aPosition := Position of: 'Pau' standingOn: 12 after: 2.
	self assert: aPosition round identicalTo: 2.
	self assert: aPosition field identicalTo: 12
]
