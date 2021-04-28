Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayerHasACertainName [
 
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer name) equals: 'Pau'.
]

{ #category : #tests }
PlayerTest >> testAPlayerHasAnInitialPositionOnTheBoardGame [
 		
	| aPlayer |
	aPlayer:= Player called: 'Pau'.
	self assert: (aPlayer actualPosition) identicalTo: 0.
]
