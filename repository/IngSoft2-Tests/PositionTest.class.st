Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testAPositionHasAFieldNumberAndRoundNumber [
 	
	|aPosition |
	aPosition:= Position 	determinedMainlyBy: 2 andSecondlyBy: 12 has: 'Pau'. 
	self assert: (aPosition round) identicalTo: 2.
	self assert: (aPosition field) identicalTo: 12.
]
